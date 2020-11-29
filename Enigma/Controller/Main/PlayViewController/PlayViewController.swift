//
//  PlayViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WidgetKit

protocol ShareDelegate : class {
    func setShare(bool : Bool, image: UIImage?)
}

class PlayViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var progressBar: xpBar!
    @IBOutlet var powerupButtons: [UIButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var answerTextField: CustomTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var subScrollView: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var previousTag : Int = 0
    var image : UIImage?
    var startingImageFrame : CGRect?
    var closePowerupOn : Bool = false
    var backgroundView : ImageScrollView!
    weak var delegate : ShareDelegate?
    var xpTimer: Timer?
    var hint : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in powerupButtons{
            setButton(button,false)
        }
        loadHint(hint: Defaults.hint())
        handleQuestion(question: Defaults.question())
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.addBorder(width: 2, .tertiary)
        hintButton.addBorder(width: 2, .tertiary)
        questionImageView.addBorder(width: 2, .tertiary)
        answerTextField.backgroundColor = #colorLiteral(red: 0.05169083923, green: 0.09415727109, blue: 0.06114685535, alpha: 1)
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        updateProgressbar()
        ServiceController.shared.getXpTime(completion: handleXp(time:))
        StoreReviewHelper.checkAndAskForReview()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        guard validate() else { return }
        setBottomButton(submitButton, true)
        let answer = AnswerModel.Request(answer: answerTextField.text ?? "")
        PostController.shared.answerQuestion(answer, closePowerupUsed: closePowerupOn, completion: handleAnswerResponse(success:close:message:))
    }
    
    
    @IBAction func hintTapped(_ sender: UIButton) {
        setBottomButton(hintButton, true)
        (hint == "") ? createHintAlert(.normal) : presentHintPreview(self.hint)
    }
    
    func validate()->Bool{
        if answerTextField.text?.isEmpty ??  true {
            presentAKAlert(type: .custom(message: AppConstants.Error.emptyAnswer))
            return false
        }
        return true
    }
    
    
    
    func handleAnswerResponse(success:Bool,close:Bool,message:String){
        setBottomButton(submitButton, false)
        if success{
            presentAKAlert(type: .success)
            processCorrectAnswer()
        } else if close {
            presentAKAlert(type: .close)
        } else {
            if closePowerupOn {
                presentAKAlert(type: .custom(message: message))
            } else {
                presentAKAlert(type: .failure)
            }
        }
    }
    
    func presentAKAlert(type: AKAlert.ALertType){
        let width = UIScreen.main.bounds.width * 0.8
        let height = width / 3.33
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let alert = AKAlert(type: type)
        alert.frame = frame
        self.view.addSubview(alert)
        alert.center = self.view.center
    }
    
    func processCorrectAnswer(){
        ServiceController.shared.getStory(completion: handleStory(story:))
        self.questionLabel.text = ""
        self.answerTextField.text = ""
        self.questionImageView.image = nil
        UserDefaults.standard.set(nil, forKey: Keys.question)
        UserDefaults.standard.set(nil, forKey: Keys.hint)
        updateProgressbar()
        resetPowerups()
        resetHint()
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    func handleStory(story:Story?){
        guard let text = story?.story?.text else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(AppConstants.ViewController.StorySnippetViewController) as! StorySnippetViewController
        viewController.text = formatStory(text)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.frame = self.view.bounds
        viewController.didMove(toParent: self)
    }
    
    func formatStory(_ story: String) -> String {
        var texts = story
        texts = texts.replacingOccurrences(of: AppConstants.Story.username, with: Defaults.username())
        texts = texts.replacingOccurrences(of: AppConstants.Story.lineBreak, with: "\n")
        return texts
    }
    
    @IBAction func powerupTapped(_ sender: UIButton) {
        let powerup = sender.tag
        let powerupButton = powerupButtons[powerup]
        
        setButton(powerupButtons[previousTag],false)
        setButton(powerupButton, true)
        
        if powerup == 1 && closePowerupOn{
            closePowerupOn = false
            setButton(powerupButtons[1],false)
        } else {
            closePowerupOn = sender.tag == 1
        }
        
        if sender.tag == 0{
            createHintAlert(.freeHint)
        } else if sender.tag == 2{
            createHintAlert(.skipQuestion)
        }
        
        
        self.previousTag = sender.tag
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let _ = questionImageView.image else { return }
        self.performZoom()
    }
    
    @IBAction func questionTapped(_ sender: Any) {
        UIPasteboard.general.string = questionLabel.text
    }
    
    
    func handleQuestion(question : Question?){
        guard  let question = question else { return }
        questionLabel.text = question.text
        questionNumberLabel.text = question.questionNumber
        asyncLoadImage(question.id ?? 0,question.imageUrl, placeHolder: nil, img: setImage(img:no:))
        ServiceController.shared.getFullStory{ _ in }
        if #available(iOS 14.0, *) {  reloadWidget()  }
        ServiceController.shared.getUserDetails { _ in self.updateProgressbar() }
    }
    
    func handleXp(time:Double){
        xpTimer?.invalidate()
        xpTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    @objc func fireTimer() {
        ServiceController.shared.getUserDetails { _ in self.updateProgressbar() }
    }
    
    @available(iOS 14.0, *)
    func reloadWidget(){
        WidgetCenter.shared.reloadTimelines(ofKind: "Enigma_Widget")
    }
    
    func setImage(img: UIImage,no:Int){
        self.image = img
        Defaults.saveImage(img.jpegData(compressionQuality: 0.7))
    }
    
    func setButton(_ button : UIButton ,_ bool : Bool){
        if !bool {
            button.addBorder(width: 1, .quaternary, alpha: 0.2)
            button.backgroundColor = .clear
        } else{
            button.addBorder(.quaternary)
            button.backgroundColor = UIColor.primary.withAlphaComponent(0.6)
        }
    }
    
    func setBottomButton(_ button : UIButton ,_ bool : Bool){
        let color : UIColor = bool ? UIColor.primary.withAlphaComponent(0.6) : .clear
        button.backgroundColor = color
        button.isEnabled = !bool
    }
    
    func updateProgressbar(){
        let progress = Defaults.xp() / maxXp
        print(Defaults.xp(),maxXp,progress)
        progressBar.animateProgress(toPercent: CGFloat(progress))
        xpLabel.text = Int(Defaults.xp()).stringValue + "xp"
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
