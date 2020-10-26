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
    var body: some View {
        Text(q)
            .onAppear{
                self.q = Defaults.question()?.text ?? "OK"
                print("OKKK: ",Defaults.question()?.text)
            }
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
