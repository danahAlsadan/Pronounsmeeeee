//
//  RootView.swift
//  Pronounsmeeeee
//
//  Created by Wed Ahmed Alasiri on 17/06/1447 AH.
//
//import SwiftUI
//
//struct RootView: View {
//    @State private var showSplash: Bool = true
//    
//    var body: some View {
//        ZStack {
//            if showSplash {
//                SplashView(showSplash: $showSplash)
//                    .transition(.opacity)       // 🔥 انتقال ناعم
//            } else {
//                OnboardingView()
////                    .transition(.opacity)  
//                // نفس الشي
////                    .transition(.scale)
//
//            }
//        }
//        .animation(.easeInOut(duration: 0.6), value: showSplash) // مدة الحركة
//    }
//}


import SwiftUI

struct RootView: View {
    @State private var showSplash = true
    @State private var hasSeenOnboarding: Bool =
        UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView(showSplash: $showSplash)   // ← السبلّاش دائمًا يظهر
            } else {
                if hasSeenOnboarding {
                    // شاف الأونبورد قبل → يروح للهوم
                    HomePage(
                        childName: UserDefaults.standard.string(forKey: "childName") ?? "",
                        profileImage: UserDefaults.standard.string(forKey: "profileImage") ?? "Boy"
                    )
                } else {
                    // أول مرة يشغل التطبيق → يعرض الأونبورد
                    OnboardingView(onFinish: {
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                        hasSeenOnboarding = true
                    })
                }
            }
        }
    }
}

#Preview {
    RootView()
}
