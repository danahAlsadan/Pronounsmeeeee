//
//  OnboardingViewModel.swift
//  Pronounsmeeeee
//
//  Created by Hneen on 22/06/1447 AH.
//
//
//  OnboardingViewModel.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 22/06/1447 AH.
//

import Foundation
import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {
    
    @Published var childName: String = ""
    @Published var selectedGender: Gender? = nil
    @Published var navigateToHome: Bool = false
    
    var canProceed: Bool {
        !childName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGender != nil
    }
    
    func saveUserData() {
        UserDefaults.standard.set(childName, forKey: "childName")
        UserDefaults.standard.set(selectedGender == .boy ? "Boy" : "Girl",
                                  forKey: "profileImage")
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
    }
    
    func selectGender(_ gender: Gender) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedGender = gender
        }
    }
}
