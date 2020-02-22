//
//  ContentView.swift
//  SwiftUISample
//
//  Created by 許　駿 on 2020/02/22.
//  Copyright © 2020 kyo_s. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("sample")
//        List(landmarks) { landmark in
//            HStack {
//                Text(landmark.name)
//                Spacer
//                if landmark.isFav {
//                    Image(systemName: "start.fill").foregroundColor(.yellow)
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Landmark {
    let name: String
    let isFav: Bool
    init(_ name: String, _ isFav: Bool) {
        self.name = name
        self.isFav = isFav
    }
}

let landmarks: [Landmark] = [
    Landmark("富士山", false),
    Landmark("横浜ランドマークタワー", true),
    Landmark("東京タワー", true),
    Landmark("sky tree", false)
]
