//
//  StarJarViewModel.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 21/06/1447 AH.
//

import Foundation
import SwiftUI
import Combine

final class StarJarViewModel: ObservableObject {

    // Keys
    private let starCountKey = "starCount"
    private let lastStarDateKey = "lastStarDate"

    // Limits
    let maxStars: Int = 28

    // UI Animation State
    @Published var showFallingStar: Bool = false
    @Published var fallOffset: CGSize = .zero

    // Insets (نفس قيمك)
    let insetHoriz: CGFloat = 70
    let insetTop: CGFloat = 24
    let insetBottom: CGFloat = 110

    var starCount: Int {
        get { UserDefaults.standard.integer(forKey: starCountKey) }
        set { UserDefaults.standard.set(newValue, forKey: starCountKey) }
    }

    var lastStarDate: String {
        get { UserDefaults.standard.string(forKey: lastStarDateKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: lastStarDateKey) }
    }

    func todayKey() -> String {
        let now = Date()
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return String(format: "%04d-%02d-%02d", comps.year ?? 0, comps.month ?? 0, comps.day ?? 0)
    }

    func canAddStarToday() -> Bool {
        lastStarDate != todayKey()
    }

    func deterministicPointInBottom(in rect: CGRect, index: Int) -> CGPoint {
        var rng = SeededGenerator(seed: UInt64(index + 67890))
        let rx = Double.random(in: 0...1, using: &rng)
        let ry = Double.random(in: 0...1, using: &rng)

        let margin: CGFloat = 8
        let w = max(rect.width - margin * 2, 0)
        let h = max(rect.height - margin * 2, 0)

        let bottomHeight = h * 0.40
        let yMin = rect.minY + margin + (h - bottomHeight)
        let y = yMin + CGFloat(ry) * bottomHeight
        let x = rect.minX + margin + CGFloat(rx) * w
        return CGPoint(x: x, y: y)
    }

    func startStarAnimation(justEarnedStar: Bool) {
        guard justEarnedStar, canAddStarToday(), starCount < maxStars else { return }

        showFallingStar = true

        let containerSize = CGSize(width: 400, height: 460)
        let safeRect = CGRect(
            x: insetHoriz,
            y: insetTop,
            width: max(containerSize.width - insetHoriz * 2, 0),
            height: max(containerSize.height - insetTop - insetBottom, 0)
        )

        let target = deterministicPointInBottom(in: safeRect, index: starCount)

        let startX: CGFloat = 0
        let startY: CGFloat = -300

        let jarCenter = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        let targetFromCenter = CGPoint(x: target.x - jarCenter.x, y: target.y - jarCenter.y)

        fallOffset = CGSize(width: startX, height: startY)

        withAnimation(.easeIn(duration: 1.0)) {
            self.fallOffset = CGSize(width: targetFromCenter.x, height: targetFromCenter.y)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.starCount = min(self.starCount + 1, self.maxStars)
            self.lastStarDate = self.todayKey()
            self.showFallingStar = false
            self.fallOffset = .zero
        }
    }
}

// نفس seeded generator (عشان ما نعتمد على ملف ثاني)
//struct SeededGenerator: RandomNumberGenerator {
//    private var state: UInt64
//
//    init(seed: UInt64) {
//        self.state = seed == 0 ? 0xdeadbeefcafebabe : seed
//    }
//
//    mutating func next() -> UInt64 {
//        var x = state
//        x &+= 0x9E3779B97F4A7C15
//        x = (x ^ (x >> 30)) &* 0xBF58476D1CE4E5B9
//        x = (x ^ (x >> 27)) &* 0x94D049BB133111EB
//        state = x ^ (x >> 31)
//        return state
//    }
//}
