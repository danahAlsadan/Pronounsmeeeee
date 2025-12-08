
//
//  HomePage.swift
//  Pronounsmeeeee
//

import SwiftUI

struct HomePage: View {
    let childName: String
    let profileImage: String
    @State private var goToMenu = false
    @State private var goTocalender = false


    @State private var starScale: CGFloat = 1.0
    var onCalendarTap: () -> Void = {}
    var onStarTap: () -> Void = {}
    
    var body: some View {
        NavigationStack {
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
                                .foregroundColor(Color(hex: "EE822B"))
                            
                            Text(childName)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        // زر الكاليندر
                        Button {
                            onCalendarTap()
                            goTocalender = true
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
                        NavigationLink("", destination: CalendarView(), isActive: $goTocalender)
                            .hidden()
                        
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    // النجمة - بحجم أكبر وثابتة
                    Button {
                        onStarTap()
                        goToMenu = true
                    } label: {
                        ZStack {
                            // النجمة الرئيسية - أكبر
                            Image( "Star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 260)
                                .foregroundColor(.yellow)
                                .shadow(color: .yellow.opacity(0.5), radius: 20)
                                .scaleEffect(starScale)
                            
                            // النص
                            Text("ابدأ\nالتمارين")
                                .font(.system(size: 28, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(hex: "EE822B"))
                        }
                    }
                    NavigationLink("", destination: d(), isActive: $goToMenu)
                        .hidden()
                    Spacer()
                    
                    // رسالة تحفيزية - لون أبيض
                    VStack(spacing: 8) {
                        Text("")
                            .font(.system(size: 40))
                        
                        Text("")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 60)
                }
            }
            .navigationBarBackButtonHidden(true)   // remove back button by defult from last page (on boarding view )
            .onAppear {
                // أنيميشن تكبير وتصغير بطيء
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    starScale = 1.15
                }
            }
        }
    }
}

#Preview {
    HomePage(childName: "أحمد", profileImage: "")
}
