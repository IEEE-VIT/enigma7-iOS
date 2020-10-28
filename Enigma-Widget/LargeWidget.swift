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
    var entry: Provider.Entry
    var body: some View {
        Group{
            if entry.isLogin {
                largeWidget(question: entry.question)
            } else {
                authError()
            }
        }
    }
    
    func isLoggedin()->Bool{
        if Defaults.token() == "" {
            return false
        } else if Defaults.question()?.text == nil {
            return false
        } else if Defaults.fetchImage() == nil {
            return false
        } else {
            return true
        }
    }
}

struct largeWidget : View {
    var question: Question?
    @State var image = UIImage(named: "bah")
    var body : some View {
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
                guard let image = Defaults.fetchImage() else { return }
                self.image = image
                return
            }
        }
    }
}

struct authError : View {
    var body : some View {
        Image("401")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.168627451, green: 0.1764705882, blue: 0.1607843137, alpha: 1)))
    }
}
