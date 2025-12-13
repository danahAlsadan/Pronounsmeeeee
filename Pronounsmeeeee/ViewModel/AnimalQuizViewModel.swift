//
//  AnimalQuizViewModel.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 21/06/1447 AH.
//
import Foundation
import SwiftUI
import Combine

final class AnimalQuizViewModel: ObservableObject {

    @AppStorage("selectedLetter") var storedLetter: String = "أ"

    let letter: String

    @Published var isCorrect: Bool = false
    @Published var selectedOption: String? = nil
    @Published var showCorrectAlert: Bool = false
    @Published var goToJar: Bool = false

    init(letter: String = "أ") {
        self.letter = letter
        if !letter.isEmpty {
            UserDefaults.standard.set(letter, forKey: "selectedLetter")
            self.storedLetter = letter
        }
    }

    // يستخدم قاموس allStories الموجود عندك (اللي معرفته في ملف AnimalQuizView)
    var effectiveLetter: String {
        let saved = UserDefaults.standard.string(forKey: "selectedLetter") ?? letter
        return allStories.keys.contains(saved) ? saved : letter
    }

    var item: StoryItem? {
        allStories[effectiveLetter]
    }

    func handleSelection(option: String) {
        selectedOption = option
        if isCorrectOption(option) {
            isCorrect = true
            showCorrectAlert = true
        } else {
            isCorrect = false
        }
    }

    func coloredFirstLetter(in word: String) -> AttributedString {
        var attr = AttributedString(word)
        let start = attr.startIndex
        if let next = attr.characters.index(start, offsetBy: 1, limitedBy: attr.endIndex) {
            attr[start..<next].foregroundColor = .black
        }
        return attr
    }

    private func normalizeArabic(_ text: String) -> String {
        let harakatRange = 0x064B...0x0652
        return String(
            text.unicodeScalars.filter { scalar in
                if scalar.value == 0x0640 { return false }
                if harakatRange.contains(Int(scalar.value)) { return false }
                if CharacterSet.whitespacesAndNewlines.contains(scalar) { return false }
                return true
            }
        )
    }

    func isCorrectOption(_ option: String) -> Bool {
        let normalizedOption = normalizeArabic(option)
        let normalizedCorrect = normalizeArabic(item?.correctOption ?? "")
        return !normalizedCorrect.isEmpty && normalizedOption == normalizedCorrect
    }
}
