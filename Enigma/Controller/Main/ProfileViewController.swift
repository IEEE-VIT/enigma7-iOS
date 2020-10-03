//
//  ProfileViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var signoutButton: UIButton!
    
    var profileDetails : [(String,String)] = []
    let profileCellIdentifier = "profilecell"
    var tableHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUserDetails(details: Defaults.user())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ServiceController.shared.getUserDetails(completion: handleUserDetails(details:))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signoutButton.addBorder(width: 2, .tertiary)
        tableHeight = profileTableView.frame.height
    }
    
    func handleUserDetails(details: UserDetails?){
        guard let user = details else { return }
        self.profileDetails = user.profileDataSource
        self.profileTableView.reloadData()
    }
    
    @IBAction func logout(_ sender: Any) {  }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: profileCellIdentifier) as! ProfileCell
        let row = indexPath.row
        let data = profileDetails[row]
        cell.keyValuePair = data
        cell.hiddenLabel = !(row == 0) || (row == 1)
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if (row == 0) || (row == 1) {
            return tableHeight * (2/7)
        } else {
            return tableHeight / 7
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
