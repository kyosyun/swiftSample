//
//  ContentView.swift
//  Landmarks
//
//  Created by 許駿 on 2020/12/08.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
                .foregroundColor(.black)
            HStack {
                    Text("Joshua Tree National Park.")
                        .font(.subheadline)
                    Text("California")
                        .font(.subheadline)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
