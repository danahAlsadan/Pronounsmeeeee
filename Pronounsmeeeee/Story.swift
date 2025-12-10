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
        options: ["أ سد" ,"ث ـعلب", "ج ـمل"],
        correctOption: "أسد",
        imageName: "أسد"
    ),
    // الباء
    "ب": StoryItem(
        storyLine:"ذهب احمد الى الحديقة ورأى",
        options: ["ب ـطة", "ف ـيل", "ت ـمساح"],
        correctOption: "بطة",
        imageName: "بطة"
    ),
    // التاء
    "ت": StoryItem(
        storyLine:"لبست الأميره",
        options: ["ح ـقيبة","ف ـستان","ت ـاج"],
        correctOption: "تاج",
        imageName: "تاج"
    ),
    // الثاء
    "ث": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ث ـعلب", "ق ـرد", "ص ـقر"],
        correctOption: "ثعلب",
        imageName: "ثعلب"
    ),
    // الجيم
    "ج": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ل ـبوه", "ع ـصفور", "ج ـمل"],
        correctOption: "جمل",
        imageName: "جمل"
    ),
    // الحاء
    "ح": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ز رافه", "ح ـصان", "ذ ئب"],
        correctOption: "حصان",
        imageName: "حصان"
    ),
    // الخاء
    "خ": StoryItem(
        storyLine: "أكلت دانه",
        options: ["خ ـيار", "ج زر", "خ ـس"],
        correctOption: "خيار",
        imageName: "خيار"
    ),
    // الدال
    "د": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ن ـمر", "دب", "ي ـمامه"],
        correctOption: "دب",
        imageName: "دب"
    ),
    // الذال
    "ذ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ذ ئب", "ب ـطة", "س ـمكة"],
        correctOption: "ذئب",
        imageName: "ذئب"
    ),
    // الراء
    "ر": StoryItem(
        storyLine: "أرسل أحمد",
        options: ["ر سالة", "واجب", "و رقة"],
        correctOption: "رسالة",
        imageName: "رسالة"
    ),
    // الزاي
    "ز": StoryItem(
        storyLine: "ذهب خالد الى الحديقة ورأى",
        options: ["ز رافة", "غ ـوريلا", "ع ـصفور"],
        correctOption: "زرافة",
        imageName: "زرافة"
    ),
    // السين
    "س": StoryItem(
        storyLine: "شاهدت يارا في البحر",
        options: ["سـ مكة", "س ـلحفاة", "س ـفينة"],
        correctOption: "سفينة",
        imageName: "سفينة"
    ),
    // الشين
    "ش": StoryItem(
        storyLine: "ذهبت ود إلى",
        options: ["ش ـاطئ", "حـ ديقة", "م درسة"],
        correctOption: "شاطئ",
        imageName: "شاطئ"
    ),
    // الصاد
    "ص": StoryItem(
        storyLine: "ذهب محمد الى الحديقة ورأى",
        options: ["ص ـقر", "ظ ـبي", "م ـاعز"],
        correctOption: "صقر",
        imageName: "صقر"
    ),
    // الضاد
    "ض": StoryItem(
        storyLine: "ذهبت حنين الى الحديقة ورأت",
        options: ["ك ـلب", "ث ـور", "ض ـفدع"],
        correctOption: "ضفدع",
        imageName: "ضفدع"
    ),
    // الطاء
    "ط": StoryItem(
        storyLine: "الطفل يلعب بـ",
        options: ["ق ـلم", "ط ـين", "طاولة"],
        correctOption: "طين",
        imageName: "طين"
    ),
    // الظاء
    "ظ": StoryItem(
        storyLine: "ذهب محمد الى الحديقة ورأى",
        options: ["غ ـوريلا", "ظ ـبي", "ز رافة"],
        correctOption: "ظبي",
        imageName: "ظبي"
    ),
    // العين
    "ع": StoryItem(
        storyLine: "لولو رأت في السماء",
        options: ["عصفور", "عين", "عنب"],
        correctOption: "عصفور",
        imageName: "عصفور"
    ),
    // الغين
    "غ": StoryItem(
        storyLine: "يارا دخلت إلى",
        options: ["غ ـرفة", "خ ـيمة", "ك ـهف"],
        correctOption: "غرفة",
        imageName: "غرفة"
    ),
    // الفاء
    "ف": StoryItem(
        storyLine: "راكان ذهب إلى الحديقة الكبيرة وشاهد",
        options: ["ف ـيل", "ف ـأر", "ف ـم"],
        correctOption: "فيل",
        imageName: "فيل"
    ),
    // القاف
    "ق": StoryItem(
        storyLine: "كتب مشعل الواجب باستخدام",
        options:["د ـفتر","ق ـلم","م ـسطرة"],
        correctOption: "قلم",
        imageName: "قلم"
    ),
    // الكاف
    "ك": StoryItem(
        storyLine: "أحمد شرب الماء من",
        options: ["ك ـوب", "م ـلعقة", "ص ـحن"],
        correctOption: "كوب",
        imageName: "كوب"
    ),
    // اللام
    "ل": StoryItem(
        storyLine: "أحمد لعب بـ",
        options: ["ل ـعبة", "د ـفتر", "ق ـلم"],
        correctOption: "لعبة",
        imageName: "لعبة"
    ),
    // الميم
    "م": StoryItem(
        storyLine: "تركي أكل",
        options: ["م ـوز", "م ـاء", "م ـلح"],
        correctOption: "موز",
        imageName: "موز"
    ),
    // النون
    "ن": StoryItem(
        storyLine: "أحمد شاهد في الغابة",
        options: ["ن ـمر", "ن ـار", "ن ـملة"],
        correctOption: "نمر",
        imageName: "نمر"
    ),
    // الهاء (هـ)
    "هـ": StoryItem(
        storyLine: "هياء رأت في السماء",
        options: ["هـ ـلال", "ع ـصفور", "ي ـمامه"],
        correctOption: "هلال",
        imageName: "هلال"
    ),
    // الواو
    "و": StoryItem(
        storyLine: "محمد شم رائحة",
        options: ["و رد", "ح ـبر", "و رق"],
        correctOption: "ورد",
        imageName: "ورد"
    ),
    // الياء
    "ي": StoryItem(
        storyLine: "أحمد رأى طائرًا جميلًا وهو",
        options: ["ي ـمامة", "هـ دهد", "ص ـقر"],
        correctOption: "يمامة",
        imageName: "يمامة"
    )
]

struct AnimalQuizView: View {
    // نقرأ الحرف المختار من d عبر AppStorage (UserDefaults)
    @AppStorage("selectedLetter") private var storedLetter: String = "أ"

    // نحافظ على توقيع المهيّئ كما هو لدعم الاستدعاءات الحالية
    let letter: String

    @State private var isCorrect = false
    @State private var selectedOption: String? = nil
    @State private var showCorrectAlert = false
    @State private var goToJar = false

    init(letter: String = "أ") {
        self.letter = letter
        // إن تم تمرير حرف صريح، نخزّنه ليكون المصدر الموحد
        if !letter.isEmpty {
            UserDefaults.standard.set(letter, forKey: "selectedLetter")
        }
    }

    // الحرف الفعلي المعروض: المفضل هو المخزّن من d، وإلا الحرف الممرر
    private var effectiveLetter: String {
        let saved = UserDefaults.standard.string(forKey: "selectedLetter") ?? letter
        return allStories.keys.contains(saved) ? saved : letter
    }

    // العنصر الحالي من قاعدة البيانات المخصصة
    private var item: StoryItem? {
        allStories[effectiveLetter]
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
                            .multilineTextAlignment(.trailing) // عربي RTL
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.black)
                        Text("............")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top, 2)
                    }
                    .padding(.top, 2)

                    // الحروف الأولى الملوّنة (من الخيارات الحالية) — بكلمة واحدة مع تلوين أول حرف
                    HStack(spacing: 20) {
                        ForEach((item?.options ?? []), id: \.self) { word in
                            Text(coloredFirstLetter(in: word))
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
        .environment(\.layoutDirection, .rightToLeft) // جعل التخطيط RTL
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

    // MARK: - Arabic first-letter coloring without breaking shaping
    private func coloredFirstLetter(in word: String) -> AttributedString {
        var attr = AttributedString(word)
        let start = attr.startIndex
        if let next = attr.characters.index(start, offsetBy: 1, limitedBy: attr.endIndex) {
            attr[start..<next].foregroundColor = .black
        }
        return attr
    }
}

#Preview {
    // جرّبي تغيير الحرف في المعاينة
    NavigationStack {
        AnimalQuizView(letter: "أ")
    }
}
