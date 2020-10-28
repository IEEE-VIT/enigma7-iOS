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
    @State var leaderboard : [Leaderboard]
    var array = Array(1...4)
    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 25){
                Text(" Rank")
                Text("UserName")
                Spacer()
                Text("Solved")
                    .offset(x: 10)
                Text("Score")
            }
            .foregroundColor(Color(.tertiary))
            .font(.custom("IBMPlexMono-SemiBold", size: 16))
            
            Text("-------------------------------------------")
                .lineLimit(nil)
                .foregroundColor(Color(.tertiary))
                .padding(.vertical, -8)
            
            HStack{
                leaderboardCell(values: array.map{$0.stringValue}, alignment: .center)
                leaderboardCell(values: leaderboard.map{$0.username ?? ""}, alignment: .center)
                Spacer()
                leaderboardCell(values: leaderboard.map{$0.solved?.stringValue ?? ""}, alignment: .center)
                leaderboardCell(values: leaderboard.map{$0.score?.stringValue ?? ""}, alignment: .center)
            }
        }.padding(.horizontal, 10)
        .background(Color(.dark))
        .onAppear{
            self.leaderboard = Array((Defaults.leaderboard() ?? []).filter{$0.username != ""}[0...4])
        }
    }
}

struct leaderboardCell : View {
    let values : [String]
    let alignment : HorizontalAlignment
    var body: some View {
        VStack(alignment: alignment){
            ForEach(values,id:\.self) { val in
                Text(val)
                    .padding(.bottom, 0.5)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color(.tertiary))
                    .font(.custom("IBMPlexMono-SemiBold", size: 16))
            }
        }
    }
}


struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(leaderboard: [Leaderboard(username: "AARYAN", solved: 5, score: 3),Leaderboard(username: "AARYAN", solved: 5, score: 3),Leaderboard(username: "AARYAN", solved: 5, score: 3),Leaderboard(username: "AARYAN", solved: 5, score: 3)])
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
