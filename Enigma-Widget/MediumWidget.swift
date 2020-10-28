//
//  MediumWidget.swift
//  Enigma-WidgetExtension
//
//  Created by Aaryan Kothari on 22/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import WidgetKit
import UIKit
struct MediumWidget: View {
    let text = "Imperdiet vitae praesent ultrices libero tincidunt magna.Imperdiet vitae praesent ultrices libero tincidunt magna.Imperdiet vitae praesent ultrices libero tincidunt magna."
    
    var body: some View{
        Group{
            if !isLoggedin() {
                authError(image:"401_medium")
            } else {
                VStack(alignment: .leading){
                    Text("Story")
                        .font(.custom("IBMPlexMono-Bold", fixedSize: 20))
                    Text(text)
                        .font(.custom("IBMPlexMono", fixedSize: 15))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(10)
                .foregroundColor(Color(.tertiary))
                .background(Color(.dark))
            }
        }
    }
    
    func isLoggedin()->Bool{
        return Defaults.token() != ""
    }
}


struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
