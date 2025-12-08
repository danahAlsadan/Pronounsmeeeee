
//
//  HomePage.swift
//  Pronounsmeeeee
//

import SwiftUI

struct HomePage: View {
    let childName: String
    let profileImage: String
    
    @State private var starScale: CGFloat = 1.0
    var onCalendarTap: () -> Void = {}
    var onStarTap: () -> Void = {}
    
    var body: some View {
        ZStack {
            // الخلفية
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // الهيدر
                HStack(spacing: 16) {
                    // صورة الطفل - أصغر
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 70, height: 70)
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: 64, height: 64)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.blue)
                    }
                    
                    // الاسم
                    VStack(alignment: .leading, spacing: 4) {
                        Text("مرحباً")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.orange)
                        
                        Text(childName)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    // زر الكاليندر
                    Button {
                        onCalendarTap()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.6))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "calendar")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 60)
                
                Spacer()
                
                // النجمة - بحجم أكبر وثابتة
                Button {
                    onStarTap()
                } label: {
                    ZStack {
                        // النجمة الرئيسية - أكبر
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                            .foregroundColor(.yellow)
                            .shadow(color: .yellow.opacity(0.5), radius: 20)
                            .scaleEffect(starScale)
                        
                        // النص
                        Text("ابدأ\nالتمارين")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                // رسالة تحفيزية - لون أبيض
                VStack(spacing: 8) {
                    Text("🌟")
                        .font(.system(size: 40))
                    
                    Text("استعد لمغامرة تعلم رائعة!")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            // أنيميشن تكبير وتصغير بطيء
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                starScale = 1.15
            }
        }
    }
}

#Preview {
    HomePage(childName: "أحمد", profileImage: "")
}
