//
//  StarJarView.swift.swift
//  Pronounsmeeeee
//
//  Created by Haya almousa on 07/12/2025.
//
import SwiftUI

struct StarJarView: View {
    let justEarnedStar: Bool          // لو true يعني الطفل توه كاسب نجمة

    // عدد النجوم المخزّنة (ينحفظ في UserDefaults تلقائيًا)
    @AppStorage("starCount") private var starCount: Int = 0

    // متغيّرات الأنيميشن
    @State private var showFallingStar = false
    @State private var fallOffset: CGFloat = -300   // تبدأ من فوق الشاشة تقريبًا

    var body: some View {
        ZStack {
            // الخلفية
            Image("خلفية الجار")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("برطمان النجوم")
                    .font(.title2)
                    .bold()
                    .padding(.top, 40)

                Spacer()

                // البرطمان + النجوم اللي داخله
                ZStack {
                    Image("جار")
                        .resizable()
                        .scaledToFit()

                    // منطقة النجوم داخل البرطمان
                    jarStarsLayer
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                }
                .frame(width: 400, height: 460)

                Spacer()
            }

            // النجمة اللي تنزل من فوق (أنيميشن)
            if showFallingStar {
                Image("نجمه")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(y: fallOffset)
            }
        }
        .onAppear {
            if justEarnedStar {
                startStarAnimation()
            }
        }
    }

    // شبكة النجوم داخل البرطمان (النجوم القديمة + الجديدة بعد الحفظ)
    private var jarStarsLayer: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                starsGrid
            }
        }
    }

    // توزيع النجوم في شكل شبكة بسيطة داخل البرطمان
    private var starsGrid: some View {
        let columns = 4
        let rows = (max(starCount, 1) + columns - 1) / columns

        return VStack(spacing: 8) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(0..<columns, id: \.self) { col in
                        let index = row * columns + col
                        if index < starCount {
                            Image("نجمه")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } else {
                            Spacer()
                                .frame(width: 26, height: 26)
                        }
                    }
                }
            }
        }
    }

    // تحريك النجمة من فوق إلى البرطمان ثم حفظها
    private func startStarAnimation() {
        showFallingStar = true
        fallOffset = -300   // البداية من فوق

        withAnimation(.easeIn(duration: 1.0)) {
            fallOffset = 80   // تنزل تقريبًا فوق البرطمان
        }

        // بعد ما تخلص الأنيميشن نحفظ النجمة ونخفي النجمة المتحركة
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            starCount += 1
            showFallingStar = false
        }
    }
}
#Preview {
    StarJarView( justEarnedStar: .init(true))
    
}
