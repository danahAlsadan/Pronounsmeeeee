//
//  ContentView.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 13/06/1447 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            RecorderView(sentences: ["باب", "برتقال", "بطة"])
//                .navigationTitle("الرئيسية")
        }
    }
}

#Preview {
//    NavigationStack {
    RecorderView(sentences: ["باب", "برتقال", "بطة"])
//    }
}
