//
//  SmallWidget.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import WidgetKit
import UIKit

struct SmallWidget: View {
    @State var data : UserDetails?
    var body: some View {
        Group{
            if isLoggedin(){
                VStack(alignment: .leading, spacing: 5){
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 120, idealWidth: 180, maxWidth: .infinity, minHeight: 40, idealHeight: 40, maxHeight: 50, alignment: .center)
                        .background(Color(UIColor.primary))
                    userName
                    profileRow(key: "Rank:", value: data?.rank?.stringValue ?? "5")
                    profileRow(key: "Score :", value: data?.points?.stringValue ?? "150")
                    profileRow(key: "Xp :", value: data?.xp?.stringValue ?? "150")
                }
                .padding(.bottom,20)
                .background(Color(.dark))
                .onAppear{
                    self.data = Defaults.user()
                }
            } else {
                authError(image:"401")
            }
        }
    }   
    
    var userName : some View {
        HStack{
            Spacer()
            Text(data?.username ?? "Yolo Yolo")
                .font(.custom("IBMPlexMono-Bold", fixedSize: 20))
                .foregroundColor(Color(.tertiary))
            Spacer()
        }
    }
    
    func isLoggedin()->Bool{
        return (Defaults.token() != "") && Defaults.startedWidget()
    }
}


struct profileRow: View {
    var key : String
    var value : String
    
    var body: some View {
        HStack{
            Text(key)
                .font(.custom("IBMPlexMono-SemiBold", size: 16))
            Text(value)
                .font(.custom("IBMPlexMono", fixedSize: 13))
        }
        .foregroundColor(Color(.tertiary))
        .padding(.leading,15)
        
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
