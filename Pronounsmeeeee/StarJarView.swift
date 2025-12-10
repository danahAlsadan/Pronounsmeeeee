//
//  StarJarView.swift.swift
//  Pronounsmeeeee
//
//  Created by Haya almousa on 07/12/2025.
//
import SwiftUI

struct StarJarView: View {
    let justEarnedStar: Bool          // لو true يعني الطفل توه كاسب نجمة

    // عدد النجوم المخزّنة (ينحفظ في UserDefaults تلقائيًا)
    @AppStorage("starCount") private var starCount: Int = 0
    // تاريخ آخر مرة أضفنا فيها نجمة (مفتاح نصي لليوم)
    @AppStorage("lastStarDate") private var lastStarDate: String = ""

    // حد أقصى للنجوم
    private let maxStars = 28

    // متغيّرات الأنيميشن
    @State private var showFallingStar = false
    @State private var fallOffset: CGSize = .zero   // نحركها 2D

    // قيم المنطقة الداخلية للبرطمان (عدّليها حسب صورتك)
    // قللنا top وزدنا bottom لتأكيد التكدس أسفل
    private let insetHoriz: CGFloat = 70
    private let insetTop: CGFloat = 24
    private let insetBottom: CGFloat = 110

    var body: some View {
        ZStack {
            // الخلفية
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("برطمان النجوم")
                    .font(.title2)
                    .bold()
                    .padding(.top, 40)

                Spacer()

                // البرطمان + النجوم اللي داخله
                ZStack {
                    Image("جار")
                        .resizable()
                        .scaledToFit()

                    // منطقة النجوم داخل البرطمان
                    jarStarsLayer
                }
                .frame(width: 400, height: 460)
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .frame(maxWidth: 360)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                )

                Spacer()
            }

            // النجمة اللي تنزل من فوق (أنيميشن)
            if showFallingStar {
                Image("نجمه")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .offset(x: fallOffset.width, y: fallOffset.height)
            }
        }
        .onAppear {
            // نجمة واحدة فقط في اليوم + الحد الأقصى
            if justEarnedStar, canAddStarToday(), starCount < maxStars {
                startStarAnimation()
            }
        }
    }

    // طبقة النجوم داخل البرطمان
    private var jarStarsLayer: some View {
        GeometryReader { geo in
            let jarRect = geo.frame(in: .local)

            // منطقة آمنة داخل البرطمان
            let safeRect = CGRect(
                x: jarRect.minX + insetHoriz,
                y: jarRect.minY + insetTop,
                width: max(jarRect.width - insetHoriz * 2, 0),
                height: max(jarRect.height - insetTop - insetBottom, 0)
            )

            ZStack {
                // النجوم المخزنة (بحد أقصى) – الآن موزعة في أسفل البرطمان
                ForEach(0..<min(starCount, maxStars), id: \.self) { index in
                    let pos = deterministicPointInBottom(in: safeRect, index: index)
                    Image("نجمه")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .position(pos)
                }
            }
        }
    }

    // نقطة ثابتة عشوائية في كامل المساحة (احتياط لو احتجناها لاحقًا)
    private func deterministicPoint(in rect: CGRect, index: Int) -> CGPoint {
        var rng = SeededGenerator(seed: UInt64(index + 12345))
        let rx = Double.random(in: 0...1, using: &rng)
        let ry = Double.random(in: 0...1, using: &rng)

        let margin: CGFloat = 8
        let w = max(rect.width - margin * 2, 0)
        let h = max(rect.height - margin * 2, 0)

        let x = rect.minX + margin + CGFloat(rx) * w
        let y = rect.minY + margin + CGFloat(ry) * h
        return CGPoint(x: x, y: y)
    }

    // نقطة ثابتة عشوائية في أسفل البرطمان (ثلث سفلي من safeRect)
    private func deterministicPointInBottom(in rect: CGRect, index: Int) -> CGPoint {
        var rng = SeededGenerator(seed: UInt64(index + 67890))
        let rx = Double.random(in: 0...1, using: &rng)
        let ry = Double.random(in: 0...1, using: &rng)

        let margin: CGFloat = 8
        let w = max(rect.width - margin * 2, 0)
        let h = max(rect.height - margin * 2, 0)

        let bottomHeight = h * 0.40 // زدناها قليلاً عشان تتسع
        let yMin = rect.minY + margin + (h - bottomHeight)
        let y = yMin + CGFloat(ry) * bottomHeight
        let x = rect.minX + margin + CGFloat(rx) * w
        return CGPoint(x: x, y: y)
    }

    // تحريك النجمة من فوق إلى أسفل البرطمان ثم حفظها (نجمة واحدة باليوم)
    private func startStarAnimation() {
        guard starCount < maxStars, canAddStarToday() else { return }

        showFallingStar = true

        // إطار البرطمان 400x460
        let containerSize = CGSize(width: 400, height: 460)
        let safeRect = CGRect(
            x: insetHoriz,
            y: insetTop,
            width: max(containerSize.width - insetHoriz * 2, 0),
            height: max(containerSize.height - insetTop - insetBottom, 0)
        )

        // الهدف: أسفل الجرة
        let target = deterministicPointInBottom(in: safeRect, index: starCount)

        // بداية من أعلى
        let startX: CGFloat = 0
        let startY: CGFloat = -300

        // تحويل الهدف بالنسبة لمركز البرطمان
        let jarCenter = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        let targetFromCenter = CGPoint(x: target.x - jarCenter.x, y: target.y - jarCenter.y)

        fallOffset = CGSize(width: startX, height: startY)

        withAnimation(.easeIn(duration: 1.0)) {
            fallOffset = CGSize(width: targetFromCenter.x, height: targetFromCenter.y)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            starCount = min(starCount + 1, maxStars)
            lastStarDate = todayKey()
            showFallingStar = false
            fallOffset = .zero
        }
    }

    // MARK: - نجمة واحدة في اليوم
    private func todayKey() -> String {
        let now = Date()
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return String(format: "%04d-%02d-%02d", comps.year ?? 0, comps.month ?? 0, comps.day ?? 0)
    }

    private func canAddStarToday() -> Bool {
        lastStarDate != todayKey()
    }
}

// مولّد أرقام عشوائية بسيط بذرة ثابتة لضمان عشوائية ثابتة لكل index
struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed == 0 ? 0xdeadbeefcafebabe : seed
    }

    mutating func next() -> UInt64 {
        var x = state
        x &+= 0x9E3779B97F4A7C15
        x = (x ^ (x >> 30)) &* 0xBF58476D1CE4E5B9
        x = (x ^ (x >> 27)) &* 0x94D049BB133111EB
        state = x ^ (x >> 31)
        return state
    }
}

#Preview {
    StarJarView(justEarnedStar: true)
}
