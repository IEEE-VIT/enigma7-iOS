//
//  LargeWidget.swift
//  Enigma-WidgetExtension
//
//  Created by Aaryan Kothari on 27/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import WidgetKit

struct LargeWidget: View {
    var question: Question?
    @State var image = UIImage(named: "bah")
    var body: some View {
        ZStack {
            Color(.primary)
            VStack(alignment: .leading){
                Group{
                    Text(question?.questionNumber ?? "")
                    Text(question?.text ?? "")
                }
                .foregroundColor(Color(.tertiary))
                .font(.custom("IBMPlexMono-SemiBold", size: 16))
                Spacer()
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color(.dark))
            .cornerRadius(20)
            .padding(10)
            .onAppear{
                    guard let question = Defaults.question()?.text else { return }
                    guard let image = Defaults.fetchImage(q: Defaults.question()?.id ?? 0) else { return }
                    self.image = image
                    return
            }
        }
    }
    
    func isLoggedin()->Bool{
        if Defaults.token() == "" {
            return false
        } else if Defaults.question()?.text == nil {
            return false
        } else if Defaults.fetchImage(q: Defaults.question()?.id ?? 0) == nil {
            return false
        } else {
            return true
        }
    }
    
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget()
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
