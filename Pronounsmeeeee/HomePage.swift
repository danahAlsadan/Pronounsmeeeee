//
//  HomePage.swift
//  Pronounsmeeeee
//

import SwiftUI

struct HomePage: View {
    let childName: String
    let profileImage: String
    
    @State private var goToMenu = false
    @State private var goToCalendar = false
    @State private var starScale: CGFloat = 1.0
    
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
                        // صورة الطفل
                        if !profileImage.isEmpty {
                            Image(profileImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 3)
                                )
                        } else {
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
                            goToCalendar = true
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
                    
                    // النجمة - مع أنيميشن خفيف جداً
                    Button {
                        goToMenu = true
                    } label: {
                        ZStack {
                            // النجمة فقط عليها الأنيميشن
                            Image("Star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260, height: 260)
                                .shadow(color: .yellow.opacity(0.5), radius: 20)
                                .scaleEffect(starScale)
                                .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: starScale)
                            
                            // النص ثابت
                            Text("ابدأ\nالتمارين")
                                .font(.system(size: 28, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(hex: "EE822B"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        starScale = 1.05  // حركة خفيفة جداً - من 1.0 إلى 1.05
                    }
                    
                    Spacer()
                    
                    // رسالة تحفيزية
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
            .navigationDestination(isPresented: $goToMenu) {
                d()
            }
            .navigationDestination(isPresented: $goToCalendar) {
                CalendarView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    HomePage(childName: "أحمد", profileImage: "Boy")
}
