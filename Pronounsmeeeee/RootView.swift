//
//  RootView.swift
//  Pronounsmeeeee
//
//  Created by Wed Ahmed Alasiri on 17/06/1447 AH.
//
import SwiftUI

struct RootView: View {
    @State private var showSplash: Bool = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView(showSplash: $showSplash)
                    .transition(.opacity)       // 🔥 انتقال ناعم
            } else {
                OnboardingView()
//                    .transition(.opacity)  
                // نفس الشي
//                    .transition(.scale)

            }
        }
        .animation(.easeInOut(duration: 0.6), value: showSplash) // مدة الحركة
    }
}
#Preview {
    RootView()
}
