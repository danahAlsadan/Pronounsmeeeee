//
//  RecorderViewModel.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 21/06/1447 AH.
//

import Foundation
import SwiftUI
import Combine

final class RecorderViewModel: ObservableObject {

    // Inputs
    let sentences: [String]

    // Dependencies
    let recognizer: SpeechRecognizer

    // Storage
    @AppStorage("selectedLetter") var selectedLetter: String = ""

    // UI State
    @Published var currentIndex: Int = 0
    @Published var isRecording: Bool = false
    @Published var resultMessage: String = ""
    @Published var showNextButton: Bool = false
    @Published var goToStory: Bool = false

    init(sentences: [String], recognizer: SpeechRecognizer = SpeechRecognizer()) {
        self.sentences = sentences
        self.recognizer = recognizer
    }

    var totalSentences: Int { sentences.count }
    var completedSentences: Int { currentIndex }

    var targetWord: String {
        guard !sentences.isEmpty else { return "" }
        return sentences[min(max(currentIndex, 0), sentences.count - 1)]
    }

    func toggleRecording() {
        if isRecording {
            recognizer.stop()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.checkWord()
            }
        } else {
            recognizer.start()
        }
        isRecording.toggle()
    }

    private func normalize(_ text: String) -> String {
        return text
            .applyingTransform(.stripCombiningMarks, reverse: false)?
            .replacingOccurrences(of: "‌", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() ?? text.lowercased()
    }

    private func checkWord() {
        let spoken = normalize(recognizer.transcript)
        let target = normalize(targetWord)

        if !target.isEmpty, spoken.contains(target) {
            resultMessage = "😁"
            showNextButton = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showNextButton = true
            }
        } else {
            resultMessage = "😕"
        }
    }

    func nextOrFinish() {
        if currentIndex == sentences.count - 1 {
            // ✅ هنا: عند إنهاء كل الجمل، نعلم الكالندر
            markTodayAsCompleted()
            goToStory = true
        } else {
            nextSentence()
        }
    }

    private func nextSentence() {
        if currentIndex < sentences.count - 1 {
            currentIndex += 1
            recognizer.transcript = ""
            resultMessage = ""
            showNextButton = false
            isRecording = false

            UserDefaults.standard.set(currentIndex + 1, forKey: "progress_\(selectedLetter)")
        } else {
            showNextButton = true
        }
    }
    
    // ✅ Function جديدة: تعليم اليوم كمنجز
    private func markTodayAsCompleted() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: today)
        
        // جلب التواريخ المحفوظة
        var dates = UserDefaults.standard.array(forKey: "completedDatesKey") as? [String] ?? []
        
        // إضافة اليوم إذا مو موجود
        if !dates.contains(dateStr) {
            dates.append(dateStr)
            UserDefaults.standard.set(dates, forKey: "completedDatesKey")
        }
    }
}
