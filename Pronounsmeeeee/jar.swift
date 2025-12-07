//
//  jar.swift
//  Pronounsmeeeee
//
//  Created by Haya almousa on 07/12/2025.
//

import SwiftUI
import Combine

// MARK: - Store for stars (daily, max 28)
// مخزن النجوم اليومي: يحفظ عدد النجوم وآخر يوم أضيفت فيه نجمة
@MainActor
final class StarJarStore: ObservableObject {
    // عدد النجوم الحالية (يُقرأ فقط من الخارج)
    @Published private(set) var starsCount: Int
    // آخر تاريخ (yyyy-MM-dd) تم فيه إضافة نجمة
    @Published private(set) var lastStarDay: String?

    // الحد الأقصى للنجوم (28)
    private let maxStars = 28
    // مفاتيح التخزين في UserDefaults
    private let starsKey = "StarJar.starsCount"
    private let lastDayKey = "StarJar.lastStarDay"

    // التهيئة: قراءة القيم من UserDefaults
    init() {
        let defaults = UserDefaults.standard
        self.starsCount = defaults.integer(forKey: starsKey)
        self.lastStarDay = defaults.string(forKey: lastDayKey)
    }

    // دالة تُرجع تاريخ اليوم كنص "yyyy-MM-dd"
    private func todayKey() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    // إضافة نجمة واحدة لليوم إذا لم تُضف بعد (ترجع true إذا أضيفت)
    func addDailyStarIfNeeded() -> Bool {
        // لا تتجاوز الحد الأقصى
        guard starsCount < maxStars else { return false }
        // تاريخ اليوم
        let today = todayKey()
        // إذا كانت نجمة اليوم مضافة مسبقًا فلا تضف
        if lastStarDay == today { return false }
        // زيادة نجمة
        starsCount += 1
        // تسجيل تاريخ اليوم
        lastStarDay = today
        // حفظ في UserDefaults
        persist()
        return true
    }

    // إعادة تعيين (للاختبار) — لا تُستخدم عادةً في الإنتاج
    func resetAll() {
        starsCount = 0
        lastStarDay = nil
        persist()
    }

    // حفظ القيم في UserDefaults
    private func persist() {
        let defaults = UserDefaults.standard
        defaults.set(starsCount, forKey: starsKey)
        defaults.set(lastStarDay, forKey: lastDayKey)
    }
}

// MARK: - Jar View
// شاشة الجرة: خلفية "خلفية الجار" + صورة "جار" (موسّطة) + شبكة نجوم + أنيميشن نجمة "نجمه"
struct JarView: View {
    // كائن التخزين
    @StateObject private var store = StarJarStore()

    // إعدادات شبكة النجوم (4 أعمدة × 7 صفوف = 28)
    private let columns = 4
    private let rows = 7
    private let maxStars = 28

    // حالة الأنيميشن
    @State private var showNewStar = false
    @State private var fallProgress: CGFloat = 0

    // نسب حجم شبكة النجوم بالنسبة للشاشة — عدّليها إذا احتجتِ
    private let GridWidthRatio: CGFloat = 0.60
    private let GridHeightRatio: CGFloat = 0.42
    // إزاحة الشبكة بالنسبة لمركز صورة الجار (لأعلى/أسفل) إذا احتجتِ ضبط أدق
    private let GridOffsetFromJarCenterY: CGFloat = 0 // بالنقاط، 0 تعني وسط الجرة

    var body: some View {
        GeometryReader { geo in
            let screenW = geo.size.width
            let screenH = geo.size.height

            // أبعاد الشبكة
            let gridW = screenW * GridWidthRatio
            let gridH = screenH * GridHeightRatio

            ZStack {
                // الخلفية
                Image("خلفية الجار")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    // عنوان أعلى الصفحة
                    Text("نجومك")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(red: 0.20, green: 0.50, blue: 0.90))
                        .padding(.top, 24)

                    // مسافة مرنة قبل الجرة
                    Spacer()

                    // كتلة الجرة في منتصف الصفحة تمامًا
                    ZStack {
                        // صورة الجرة "جار" — يتم توسيطها تلقائيًا داخل هذا الـ ZStack
                        Image("جار")
                            .resizable()
                            .scaledToFit()
                            .frame(width: min(screenW * 0.78, 360))

                        // شبكة النجوم فوق الجرة، متمركزة في وسط نفس الحاوية
                        ZStack {
                            // النجوم المتراكمة (نخصم 1 أثناء عرض النجمة المتحركة)
                            starsGrid(stars: store.starsCount - (showNewStar ? 1 : 0))
                                .frame(width: gridW, height: gridH)

                            // النجمة الساقطة "نجمه" إلى منتصف الشبكة عند إضافة نجمة جديدة
                            if showNewStar {
                                FallingStarToCenter(progress: fallProgress)
                                    .frame(width: gridW, height: gridH)
                                    .allowsHitTesting(false)
                            }
                        }
                        // لو احتجتِ رفع/خفض الشبكة نسبة بسيطة بالنسبة لمركز الجرة، عدّلي هذا الإزاحة
                        .offset(y: GridOffsetFromJarCenterY)
                    }
                    // هذه الـ ZStack (الجار+الشبكة) موجودة بين Spacerين، لذا هي في منتصف الصفحة عموديًا

                    // مسافة مرنة بعد الجرة
                    Spacer()

                    // عدّاد النجوم أسفل الصفحة
                    Text("\(store.starsCount)/\(maxStars)")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black.opacity(0.85))
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                if store.addDailyStarIfNeeded() {
                    showNewStar = true
                    fallProgress = 0
                    withAnimation(.easeOut(duration: 1.0)) {
                        fallProgress = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showNewStar = false
                    }
                } else {
                    showNewStar = false
                }
            }
        }
    }

    // شبكة عرض النجوم المتراكمة
    @ViewBuilder
    private func starsGrid(stars: Int) -> some View {
        GeometryReader { geo in
            let cellW = geo.size.width / CGFloat(columns)
            let cellH = geo.size.height / CGFloat(rows)
            // كبرنا النجمة داخل الخلية من 0.7 إلى 0.85
            let starSize = min(cellW, cellH) * 0.85

            ZStack {
                ForEach(0..<max(0, min(stars, maxStars)), id: \.self) { index in
                    let row = index / columns
                    let col = index % columns
                    Image("نجمه")
                        .resizable()
                        .scaledToFit()
                        .frame(width: starSize, height: starSize)
                        .position(x: (CGFloat(col) + 0.5) * cellW,
                                  y: (CGFloat(row) + 0.5) * cellH)
                }
            }
        }
    }
}

// MARK: - Falling star "نجمه" that drops to the center of its container
struct FallingStarToCenter: View {
    let progress: CGFloat // 0..1

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            let startY = -h * 0.3
            let endY = h * 0.5
            let currentY = startY + (endY - startY) * progress

            // كبرنا الحجم الأساسي من 0.18 إلى 0.22
            let base = min(w, h) * 0.22
            // زدنا التكبير أثناء السقوط من (0.6..1.0) إلى (0.65..1.10)
            let scale = 0.65 + 0.45 * progress

            Image("نجمه")
                .resizable()
                .scaledToFit()
                .frame(width: base * scale, height: base * scale)
                .position(x: w * 0.5, y: currentY)
                .opacity(Double(0.5 + 0.5 * progress))
        }
    }
}

#Preview {
    JarView()
}
