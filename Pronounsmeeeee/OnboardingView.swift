//
//  OnboardingView.swift
//  Pronounsmeeeee
//

import SwiftUI

struct OnboardingView: View {
    @State private var childName: String = ""
    @State private var selectedGender: Gender? = nil
    
    private let accentColor = Color(hex: "#EE822B")
    @State private var navigateToHome: Bool = false

    private var canProceed: Bool {
        !childName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGender != nil
    }
    var onFinish: (() -> Void)? = nil//wed

    
    var body: some View {
        NavigationStack {
            ZStack {
                // الخلفية
                Image("SplashBackRound")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // MARK: - Hello + Name (متمركزة بالكامل بس نازلة شوي)
                    VStack(spacing: 3) {
                        
                        HStack(spacing: 10) {
                            Text("Hello")
                                .font(.system(size: 35, weight: .bold))
                                .italic()
                                .foregroundColor(accentColor)
                            
                            TextField("", text: $childName)
                                .font(.system(size: 35, weight: .semibold))
                                .italic()
                                .foregroundColor(accentColor.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .placeholder(when: childName.isEmpty) {
                                    Text("Name")
                                        .font(.system(size: 35, weight: .semibold))
                                        .italic()
                                        .foregroundColor(accentColor.opacity(0.50))
                                }
                                .frame(maxWidth: 120)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)

                        Rectangle()
                            .fill(accentColor.opacity(0.4))
                            .frame(width: 250, height: 3)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    // ✳️ نزّلته أكثر تحت
                    .padding(.top, 180)   // جربي 140–160 لين يضبط معاك
                    
                    // مسافة تحت الهيدر
                    Spacer().frame(height: 1)
                    
                    // MARK: - Boy / Girl
                    // MARK: - Boy / Girl with stars
                    HStack(spacing: 20) {
                        genderColumn(type: .boy)
                        genderColumn(type: .girl)
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    // MARK: - زر Let’s Practice
                    if canProceed {
                        Button {
                            //wed
                            saveUserData()
                               UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                               onFinish?()        // ← يعلم الـ Rootview إنه خلص
                               navigateToHome = true
                            //wed
                        } label: {
                            Text("بدأ")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(accentColor)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 14)
                                .background(
                                    Capsule()
                                        .fill(Color.yellow.opacity(0.9))
                                        .shadow(radius: 4, y: 3)
                                )
                        }
                        .padding(.bottom, 40)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        
                    } else {
                        Spacer().frame(height: 40)
                    }
                }
                .padding(.horizontal, 24)
            }
            // *** هنا التنقّل حق الكود الأول بس ***
                        .navigationDestination(isPresented: $navigateToHome) {
                            HomePage(
                                childName: childName,
                                profileImage: selectedGender == .boy ? "Boy" : "Girl"
                            )
                        }
                        .navigationBarBackButtonHidden(true)
        }
        // الكيبورد ما يلعب في الـ safe area من تحت
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    // حفظ البيانات في UserDefaults
    private func saveUserData() {
        UserDefaults.standard.set(childName, forKey: "childName")
        UserDefaults.standard.set(selectedGender == .boy ? "Boy" : "Girl", forKey: "profileImage")
    }
    
    // MARK: - عمود ولد/بنت
    private func genderColumn(type: Gender) -> some View {
        let isSelected = selectedGender == type
        
        return VStack(spacing: 5) {
            Image(type == .boy ? "Boy" : "Girl")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            Button {
                selectedGender = type
            } label: {
                ZStack {
                    Image("Star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 140)
                        .scaleEffect(isSelected ? 1.08 : 1.0)
                        .shadow(color: isSelected ? accentColor.opacity(0.4) : .clear,
                                radius: 8, y: 4)
                    
                    Text(type == .boy ? "ولد" : "بنت")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(accentColor)
                }
            }
            .buttonStyle(.plain)
            .animation(.easeInOut(duration: 0.2), value: selectedGender)
        }
    }
}

enum Gender {
    case boy
    case girl
}

// Placeholder modifier
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}

#Preview {
    OnboardingView()
}
