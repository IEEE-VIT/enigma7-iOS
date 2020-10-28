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
    var body: some View {
        Text("Hello, World!")
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget()
            .previewContext(WidgetPreviewContext(family: .systemMedium))

    }
}
