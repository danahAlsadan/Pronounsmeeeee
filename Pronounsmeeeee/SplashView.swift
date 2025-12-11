import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    @State private var starScale: CGFloat = 0.6
    @State private var starOpacity: Double = 0
    @State private var bounce: Bool = false
    
    var body: some View {
        ZStack {
            // خلفية السبلاش
            Image("SplashBackRound")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // النجمة مع الشعار
            Image("SplashStar")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 800)          // اقدر اكبر و اصغر النجمة
                .opacity(starOpacity)
                .scaleEffect(starScale)
                .offset(y: bounce ? -30 : 0) // حركة لطيفة فوق/تحت
        }
        .onAppear {
            runAnimation()
        }
    }
    
    private func runAnimation() {
        // 1) تظهر النجمة مع تكبير لطيف
        withAnimation(.easeOut(duration: 0.7)) {
            starOpacity = 1
            starScale = 1.05
        }
        
        // 2) ترجع لحجمها الطبيعي مع بونس خفيف
        withAnimation(
            .interpolatingSpring(stiffness: 180, damping: 14)
                .delay(0.1)
        ) {
            starScale = 1.0
        }
        
        // 3) حركة طالع/نازل بسيطة متكررة
        withAnimation(
            .easeInOut(duration: 0.9)
                .repeatForever(autoreverses: true)
                .delay(0.8)
        ) {
            bounce = true
        }
        
        // 4) بعد 2.7 ثانية نطلع من السبلاش (تقدرين تغيرين الوقت)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                showSplash = false
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(showSplash: .constant(true))
    }
}
