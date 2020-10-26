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
    @State var q : String = ""
    @State var image = UIImage()
    var body: some View {
        VStack(alignment: .leading){
        
        Text(q)
            .foregroundColor(Color(.tertiary))
            .font(.custom("IBMPlexMono-SemiBold", size: 16))
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal, 20)
        .background(Color(.dark))
        .onAppear{
            self.q = Defaults.question()?.text ?? "OK"
            print("OKKK: ", Defaults.question()?.text)
            print("IMAGE:", Defaults.fetchImage(q: Defaults.question()?.id ?? 0))
            self.image = Defaults.fetchImage(q: Defaults.question()?.id ?? 0) ?? UIImage()
        }
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
