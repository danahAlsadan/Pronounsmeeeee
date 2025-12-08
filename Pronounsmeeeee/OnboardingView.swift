import SwiftUI

struct OnboardingView: View {
    @State private var childName: String = ""
    @State private var selectedGender: Gender? = nil
    
    private let accentColor = Color(hex: "#EE822B")
    @State private var navigateToHome: Bool = false

    // يظهر زر Let’s Practice لما الاسم مو فاضي + اختيار الجنس
    private var canProceed: Bool {
        !childName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGender != nil
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // خلفية زرقاء من الصورة
                Image("SplashBackRound")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    // MARK: - Hello + Name (متمركزة بالكامل)
                    VStack(spacing: 6) {
                        
                        HStack(spacing: 15) {
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
                                        .foregroundColor(accentColor.opacity(0.35))
                                }
                                .frame(maxWidth: 100)  // يمنع التمدد لليمين ويسار
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                        
                        Rectangle()
                            .fill(accentColor.opacity(0.4))
                            .frame(width: 250, height: 3)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)
                    
                    // مسافة إضافية عشان ننزل الشخصيات والنجوم
                    Spacer().frame(height: 70)
                    
                    // MARK: - Boy / Girl with stars (منزّلة تحت شوي)
                    HStack(spacing: 45) {
                        genderColumn(type: .boy)
                        genderColumn(type: .girl)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // MARK: - Let’s Practice button
                    if canProceed {
                        Button {
                            navigateToHome = true
                        } label: {
                            Text("Let’s Practice")
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
                        
                        // رابط الانتقال للصفحة
                        NavigationLink(
                            destination: HomePage(childName: childName, profileImage: ""),
                            isActive: $navigateToHome
                        ) {
                            EmptyView()
                        }
                        .hidden()
                        
                    } else {
                        Spacer().frame(height: 40)
                    }
                }
                .padding(.horizontal, 24)
            }
            // 👇 هذا اللي يخلي الهيدر ثابت وما يطلع مع الكيبورد
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    // MARK: - عمود ولد/بنت (الصورة + النجمة الزر)
    private func genderColumn(type: Gender) -> some View {
        let isSelected = selectedGender == type
        
        return VStack(spacing: 5) {
            // صورة الولد/البنت
            Image(type == .boy ? "Boy" : "Girl")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            // زر النجمة
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
                    
                    Text(type == .boy ? "Boy" : "Girl")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(accentColor)
                }
            }
            .buttonStyle(.plain)
            .animation(.easeInOut(duration: 0.2), value: selectedGender)
        }
    }
}

// نوع الجنس
enum Gender {
    case boy
    case girl
}

// Placeholder modifier للـ TextField
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

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
