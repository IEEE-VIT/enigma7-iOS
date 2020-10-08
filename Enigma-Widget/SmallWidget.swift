//
//  SmallWidget.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct SmallWidget: View {
    @State var data : UserDetails?
    var body: some View {
        VStack{
        Image("Enigma")
            Spacer()
        Text("Hello, World!")
            .foregroundColor(.white)
        }.background(Color(.dark))
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
