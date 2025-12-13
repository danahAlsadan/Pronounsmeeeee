import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    private let accentColor = Color(hex: "#EE822B")
    
    var onFinish: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("SplashBackRound")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    VStack(spacing: 8) {
                        Text("Hello")
                            .font(.system(size: 40, weight: .bold))
                            .italic()
                            .foregroundColor(accentColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        TextField("", text: $viewModel.childName, prompt: Text("أدخل الاسم")
                            .font(.system(size: 30, weight: .semibold))
                            .italic()
                            .foregroundColor(accentColor.opacity(0.4))
                        )
                            .font(.system(size: 35, weight: .semibold))
                            .italic()
                            .foregroundColor(accentColor.opacity(0.85))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Rectangle()
                            .fill(accentColor.opacity(0.4))
                            .frame(width: 150, height: 3)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, 180)
                    
                    Spacer().frame(height: 1)
                    
                    HStack(spacing: 20) {
                        genderColumn(type: .boy)
                        genderColumn(type: .girl)
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    if viewModel.canProceed {
                        Button {
                            viewModel.saveUserData()
                            onFinish?()
                            viewModel.navigateToHome = true
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
            .navigationDestination(isPresented: $viewModel.navigateToHome) {
                HomePage(
                    childName: viewModel.childName,
                    profileImage: viewModel.selectedGender == .boy ? "Boy" : "Girl"
                )
            }
            .navigationBarBackButtonHidden(true)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func genderColumn(type: Gender) -> some View {
        let isSelected = viewModel.selectedGender == type
        
        return VStack(spacing: 5) {
            Image(type == .boy ? "Boy" : "Girl")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .opacity(isSelected || viewModel.selectedGender == nil ? 1.0 : 0.5)
            
            Button {
                viewModel.selectGender(type)
            } label: {
                ZStack {
                    Image("Star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 140)
                        .scaleEffect(isSelected ? 1.15 : 1.0)
                        .colorMultiply(isSelected ? Color.yellow : Color.gray.opacity(0.6))
                        .shadow(color: isSelected ? Color.yellow.opacity(0.6) : .clear,
                                radius: 12, y: 6)
                    
                    Text(type == .boy ? "ولد" : "بنت")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(isSelected ? accentColor : Color.gray.opacity(0.7))
                }
            }
            .buttonStyle(.plain)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.selectedGender)
        }
    }
}

#Preview {
    OnboardingView()
}
