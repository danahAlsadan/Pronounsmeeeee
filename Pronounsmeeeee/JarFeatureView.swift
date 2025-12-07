//
//  JarFeatureView.swift
//  Pronounsmeeeee
//
//  Created by Haya almousa on 07/12/2025.
//

import SwiftUI

// MARK: - زر بسيط تضيفينه بأي شاشة، يودّي للبرطمان ويشغل الأنيميشن
struct JarEntryButton: View {
    @State private var goToJar = false

    var body: some View {
        VStack {
            Button("✨ الاستمرار للبرطمان") {
                goToJar = true
            }
            .padding()
            .background(.yellow.opacity(0.3))
            .cornerRadius(12)

            NavigationLink(
                "",
                destination: StarJarView(justEarnedStar: true),
                isActive: $goToJar
            )
            .hidden()
        }
    }
}
