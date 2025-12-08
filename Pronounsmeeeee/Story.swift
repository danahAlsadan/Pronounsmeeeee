//
//  Story.swift
//  Pronounsmeeeee
//
//  Created by Haya almousa on 06/12/2025.
//

import SwiftUI

struct CurvedHeader: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.maxY * 0.6),
            control: CGPoint(x: rect.midX, y: rect.maxY * 1.2)
        )
        path.addLine(to: .zero)
        return path
    }
}

// نموذج بيانات السؤال/القصة
struct StoryItem {
    let storyLine: String           // مثال: "أحمد ذهب إلى الحديقة ورأى"
    let options: [String]           // 3 خيارات
    let correctOption: String       // الصحيح
    let imageName: String           // اسم الصورة في الأصول (عادة = correctOption)
}

// قاعدة بيانات القصص المخصصة لكل حرف (أكملي بقية الحروف بنفس النمط)
private let allStories: [String: StoryItem] = [
    // الألف
    "أ": StoryItem(
        storyLine: "ذهب احمد الى حديقة الحيوان ورأى",
        options: ["أسد" ,"ثعلب", "جمل"],
        correctOption: "أسد",
        imageName: "أسد"
    ),
    // الباء
    "ب": StoryItem(
        storyLine:"ذهب احمد الى الحديقة ورأى",
        options: ["بطة", "فيل", "تمساح"],
        correctOption: "بطة",
        imageName: "بطة"
    ),
    // التاء
    "ت": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["خروف", "تمساح", "أرنب"],
        correctOption: "تمساح",
        imageName: "تمساح"
    ),
    // الثاء
    "ث": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ثعلب", "قرد", "صقر"],
        correctOption: "ثعلب",
        imageName: "ثعلب"
    ),
    // الجيم
    "ج": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["لبوه", "عصفور", "جمل"],
        correctOption: "جمل",
        imageName: "جمل"
    ),
    // الحاء
    "ح": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["زرافه", "حصان", "ذئب"],
        correctOption: "حصان",
        imageName: "حصان"
    ),
    // الخاء
    "خ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["خروف", "نحل", "صقر"],
        correctOption: "خروف",
        imageName: "خروف"
    ),
    // الدال
    "د": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["نمر", "دب", "يمامه"],
        correctOption: "دب",
        imageName: "دب"
    ),
    // الذال
    "ذ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ذئب", "بطة", "سمكة"],
        correctOption: "ذئب",
        imageName: "ذئب"
    ),
    // الراء
    "ر": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["عصفور", "راكون", "فيل"],
        correctOption: "رمان",
        imageName: "راكون"
    ),
    // الزاي
    "ز": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["زرافة", "غوريلا", "عصفور"],
        correctOption: "زرافة",
        imageName: "زرافة"
    ),
    // السين
    "س": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["كلب", "غزال", "سلحفاة"],
        correctOption: "سلحفاة",
        imageName: "سلحفاة"
    ),
    // الشين
    "ش": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["شجرة", "شمس", "شاي"],
        correctOption: "شجرة",
        imageName: "شجرة"
    ),
    // الصاد
    "ص": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["صقر", "ظبي", "ماعز"],
        correctOption: "صقر",
        imageName: "صقر"
    ),
    // الضاد
    "ض": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["كلب", "ثور", "ضفدع"],
        correctOption: "ضفدع",
        imageName: "ضفدع"
    ),
    // الطاء
    "ط": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["نمر", "طاؤوس", "أسد"],
        correctOption: "طاؤوس",
        imageName: "طاؤوس"
    ),
    // الظاء
    "ظ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["غوريلا", "ظبي", "زرافة"],
        correctOption: "ظبي",
        imageName: "ظبي"
    ),
    // العين
    "ع": StoryItem(
        storyLine: "أحمد رأى في السماء",
        options: ["عصفور", "عين", "عنب"],
        correctOption: "عصفور",
        imageName: "عصفور"
    ),
    // الغين
    "غ": StoryItem(
        storyLine: "أحمد نظر إلى السماء فشاهد",
        options: ["غيمة", "غراب", "غطاء"],
        correctOption: "غيمة",
        imageName: "غيمة"
    ),
    // الفاء
    "ف": StoryItem(
        storyLine: "أحمد ذهب إلى الحديقة الكبيرة وشاهد",
        options: ["فيل", "فأر", "فم"],
        correctOption: "فيل",
        imageName: "فيل"
    ),
    // القاف
    "ق": StoryItem(
        storyLine: "أحمد نظر إلى السماء فرأى",
        options: ["قمر", "قلم", "قطة"],
        correctOption: "قمر",
        imageName: "قمر"
    ),
    // الكاف
    "ك": StoryItem(
        storyLine: "أحمد شرب الماء من",
        options: ["كوب", "كتاب", "كرسي"],
        correctOption: "كوب",
        imageName: "كوب"
    ),
    // اللام
    "ل": StoryItem(
        storyLine: "أحمد لعب بـ",
        options: ["لعبة", "لبن", "لؤلؤ"],
        correctOption: "لعبة",
        imageName: "لعبة"
    ),
    // الميم
    "م": StoryItem(
        storyLine: "أحمد أكل",
        options: ["موز", "ماء", "ملح"],
        correctOption: "موز",
        imageName: "موز"
    ),
    // النون
    "ن": StoryItem(
        storyLine: "أحمد شاهد في الغابة",
        options: ["نمر", "نار", "نملة"],
        correctOption: "نمر",
        imageName: "نمر"
    ),
    // الهاء (هـ)
    "هـ": StoryItem(
        storyLine: "أحمد رأى في السماء",
        options: ["هلال", "هر", "هدهد"],
        correctOption: "هلال",
        imageName: "هلال"
    ),
    // الواو
    "و": StoryItem(
        storyLine: "أحمد شم رائحة",
        options: ["ورد", "وجه", "ورق"],
        correctOption: "ورد",
        imageName: "ورد"
    ),
    // الياء
    "ي": StoryItem(
        storyLine: "أحمد رأى طائرًا جميلًا هو",
        options: ["يمامة", "يد", "يوم"],
        correctOption: "يمامة",
        imageName: "يمامة"
    )
]

struct AnimalQuizView: View {
    // الحرف المختار القادم من d / VideoPage / RecorderView
    let letter: String

    // حالة العرض
    @State private var isCorrect = false
    @State private var selectedOption: String? = nil
    @State private var showCorrectAlert = false
    @State private var goToJar = false

    // مُهيّئ افتراضي لتسهيل المعاينة والتشغيل بدون تعديل ملفات أخرى
    init(letter: String = "أ") {
        self.letter = letter
    }

    // العنصر الحالي من قاعدة البيانات المخصصة
    private var item: StoryItem? {
        allStories[letter]
    }

    var body: some View {
        ZStack(alignment: .top) {
            // الخلفية
            Image("خلفيتي")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // NavigationLink مخفي للانتقال للبرطمان
                NavigationLink(
                    "",
                    destination: StarJarView(justEarnedStar: true),
                    isActive: $goToJar
                )
                .hidden()

                Spacer(minLength: 0)

                // بطاقة القصة + الحروف الأولى الملونة + الصورة
                VStack(spacing: 0) {
                    // نص القصة
                    VStack(spacing: 0) {
                        Text(item?.storyLine ?? "أحمد ذهب إلى الحديقة ورأى")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.black)
                        Text("............")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top, 2)
                    }
                    .padding(.top, 2)

                    // الحروف الأولى الملوّنة (من الخيارات الحالية)
                    HStack(spacing: 20) {
                        ForEach((item?.options ?? []), id: \.self) { word in
                            let first = String(word.prefix(1))
                            let rest = String(word.dropFirst())
                            HStack(spacing: 0) {
                                Text(first)
                                    .foregroundColor(.brown)
                                Text(rest)
                                    .foregroundColor(.black)
                            }
                            .font(.system(size: 24, weight: .regular))
                        }
                    }
                    .padding(.horizontal, 12)

                    // صورة الحيوان (اسمها = imageName)
                    if let imageName = item?.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .padding(.top, 2)
                    } else {
                        Rectangle()
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 250, height: 250)
                            .overlay(
                                Text("لا توجد صورة")
                                    .foregroundColor(.gray)
                            )
                            .padding(.top, 2)
                    }
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .frame(maxWidth: 560)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                )
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 8)
                .shadow(color: .white.opacity(0.2), radius: 2, x: -1, y: -1)
                .padding(.horizontal, 30)

                // أزرار الخيارات
                HStack(spacing: 12) {
                    ForEach((item?.options ?? []), id: \.self) { option in
                        liquidGlassButton(title: option) {
                            handleSelection(option: option)
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 40)

                Spacer(minLength: 0)
            }
        }
        .alert("أحسنت!", isPresented: $showCorrectAlert) {
            Button("متابعة") {
                goToJar = true
            }
        } message: {
            Text("إجابة صحيحة.")
        }
    }

    // MARK: - Actions
    private func handleSelection(option: String) {
        selectedOption = option
        if option == item?.correctOption {
            isCorrect = true
            showCorrectAlert = true
        } else {
            isCorrect = false
        }
    }

    // MARK: - Components
    @ViewBuilder
    private func liquidGlassButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            let isSelected = selectedOption == title
            let isRight = title == item?.correctOption
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(isSelected ? (isRight ? .green : .red) : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color(hex: "F3BB34"))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color(hex: "F3BB34"))
                )
        }
        // بعد اختيار الصحيح، نوقف الأزرار الأخرى
        .disabled(isCorrect && title != item?.correctOption)
    }
}

#Preview {
    // جرّبي تغيير الحرف في المعاينة
    NavigationStack {
        AnimalQuizView(letter: "ث")
    }
}
