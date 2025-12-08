//
//  d.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 13/06/1447 AH.
//


import SwiftUI

struct d: View {
    var body: some View {
        NavigationStack {
            MenuView()
        }
    }
}

struct MenuView: View {
    
    // ✅ إضافة 1: تخزين الحرف المختار في AppStorage بنفس المفتاح المستخدم في AnimalQuizView
    @AppStorage("selectedLetter") private var selectedLetter: String = "أ"
    
    let letterImages: [String] = [
        "أ", "ب", "ت", "ث", "ج", "ح", "خ",
        "د", "ذ", "ر", "ز", "س", "ش", "ص",
        "ض", "ط", "ظ", "ع", "غ", "ف", "ق",
        "ك", "ل", "م", "ن", "هـ", "و", "ي"
    ]

    //wed Exercises
    
//     letterExercises[letter] = [ level0Words, level1Words, level2Sentences ]
    let letterSentences: [String: [[String]]] = [

    
        "أ": [
            ["أسد", "أرنب", "أذن"],//level 0
            ["أمام", "أحمر", "أطفال"],//level 1
            ["الأرنب يجري بسرعة", "أمي تفتح الباب", "الأسد قوي"]//level 2
        ],

        "ب": [
            ["باب", "بيت", "بطة"],
            ["بطاقة", "بسكويت", "بالون"],
            ["البطة تمشي ببطء", "باب البيت مفتوح", "أنا أحب البسكويت"]
        ],

        "ت": [
            ["تفاح", "تمر", "تاج"],
            ["تمساح", "تجربة", "تعب"],
            ["الطفل يأكل تفاحة", "التمساح كبير", "توت لذيذ"]
        ],
        
        "ث": [
            ["ثعلب", "ثمرة", "ثلاث"],
            ["ثوب", "ثقيل", "ثلج"],
            ["الثعلب صغير", "الثوب نظيف", "الثلاثة على الطاولة"]
        ],

      
        "ج": [
            ["جمل", "جبل", "جرس"],
            ["جزرة", "جريدة", "جانب"],
            ["الجمل يمشي ببطء", "جرس المدرسة يرن", "الولد فوق الجبل"]
        ],


        "ح": [
            ["حصان", "حبل", "حب"],
            ["حمار", "حلة", "حقيبة"],
            ["الحصان يجري", "حقيبتي ثقيلة", "أحب الحلوى"]
        ],

    
        "خ": [
            ["خبز", "خروف", "خيط"],
            ["خزانة", "خيار", "خس"],
            ["الخبز حار", "الخروف ناعم", "الخيط رفيع"]
        ],

 
        "د": [
            ["دب", "درج", "دلو"],
            ["دكان", "دورة", "دباغ"],
            ["الدب ينام", "الدرج طويل", "أفتح الدلو"]
        ],


        "ذ": [
            ["ذهب", "ذيل", "ذرة"],
            ["ذئب", "ذهن", "ذراع"],
            ["الذيل طويل", "الذرة صفراء", "ذهب لامع"]
        ],

        "ر": [
            ["رجل", "رأس", "رمان"],
            ["رصيف", "رتب", "رسالة"],
            ["الرجل يمشي", "رأس الطفل صغير", "رمانة حمراء"]
        ],

   
        "ز": [
            ["زرافة", "زر", "زيت"],
            ["زهر", "زمن", "زيارة"],
            ["الزرافة طويلة", "الزر أخضر", "الزيت سائِل"]
        ],

 
        "س": [
            ["سمك", "سيف", "سور"],
            ["سفينة", "سوق", "سلة"],
            ["السمك يسبح", "السوق مزدحم", "السيف حاد"]
        ],

        "ش": [
            ["شمس", "شاي", "شجرة"],
            ["شباك", "شارة", "شاطئ"],
            ["الشمس ساطعة", "الشاي ساخن", "الشجرة كبيرة"]
        ],

      
        "ص": [
            ["صقر", "صندوق", "صوت",],
            ["صابون", "صحيفة", "صديق"],
            ["الصقر يير", "الصندوق مغلق", "الصوت عالي"]
        ],

        "ض": [
            ["ضوء", "ضرس", "ضفدع"],
            ["ضباب", "ضمان", "ضاحية"],
            ["الضوء قوي", "الضفدع يقفز", "الضرس يؤلم"]
        ],

        "ط": [
            ["طير", "طاولة", "طين"],
            ["طبيب", "طبق", "طائرة"],
            ["الطير يغرد", "الطاولة كبيرة", "الطفل يلعب بالطين"]
        ],

        "ظ": [
            ["ظرف", "ظل", "ظبي"],
            ["ظرف", "ظهور", "ظرفية"],
            ["الظل طويل", "الظبي جميل", "وضع الظرف هنا"]
        ],

        "ع": [
            ["عين", "عنب", "علم"],
            ["عصفور", "عربة", "عطر"],
            ["العين كبيرة", "العنب حلو", "العلم يرفرف"]
        ],

        "غ": [
            ["غيمة", "غراب", "غطاء"],
            ["غرفة", "غذاء", "غناء"],
            ["الغيمة تمطر", "الغراب يطير", "الغطاء دافئ"]
        ],

        "ف": [
            ["فيل", "فم", "فأر"],
            ["فصل", "فستان", "فرد"],
            ["الفيل كبير", "الفم مفتوح", "الفأر صغير"]
        ],

        "ق": [
            ["قمر", "قلم", "قطة"],
            ["قارب", "قاعة", "قفل"],
            ["القمر جميل", "القلم جديد", "القطة نائمة"]
        ],

        "ك": [
            ["كتاب", "كرسي", "كوب"],
            ["كهف", "كبر", "كرة"],
            ["الكتاب مفتوح", "الكرسي مريح", "الكوب مليان"]
        ],

        "ل": [
            ["لبن", "لعبة", "لؤلؤ"],
            ["لمبة", "لف", "لحن"],
            ["اللعبة جديدة", "اللبن بارد", "اللؤلؤ لامع"]
        ],

        "م": [
            ["موز", "ماء", "ملح"],
            ["مفتاح", "مكتبة", "مقعد"],
            ["الماء بارد", "المفتاح في الجيب", "الموز طازج"]
        ],

        "ن": [
            ["نار", "نمر", "نملة"],
            ["نقش", "نظارة", "نبتة"],
            ["النار دافئة", "النملة صغيرة", "النمر قوي"]
        ],

        "هـ": [
            ["هلال", "هر", "هدهد"],
            ["هدية", "هاتف", "هجرة"],
            ["الهلال ظاهر", "الهر نائم", "أعطيت هدية"]
        ],

        "و": [
            ["ورد", "ورق", "وجه"],
            ["وسادة", "وادي", "وانية"],
            ["الورد جميل", "الوجه مبتسم", "الورق أبيض"]
        ],

        "ي": [
            ["يد", "يمامة", "يلمح"],
            ["يدوية", "يريد", "يوم"],
            ["اليد صغيرة", "اليمامة تطير", "اليوم جميل"]
        ]
    ]

    let letterData: [String: ([String], String)] = [
        "أ": (["أِ", "أُ", "أَ"], "biWQsbDq5O0"),
        "ب": (["بِ", "بُ", "بَ"], "6VWsmWhB4LQ"),
        "ت": (["تِ", "تُ", "تَ"], "p7l-P1YVcAE"),
        "ث": (["ثِ", "ثُ", "ثَ"], "hWDpiKdh__8"),
        "ج": (["جِ", "جُ", "جَ"], "k03QMqfpBII"),
        "ح": (["حِ", "حُ", "حَ"], "OWU8f6YpRQI"),
        "خ": (["خِ", "خُ", "خَ"], "PO_0ziifmLk"),
        "د": (["دِ", "دُ", "دَ"], "w0UyDk81P5A"),
        "ذ": (["ذِ", "ذُ", "ذَ"], "eJb22eV5alw"),
        "ر": (["رِ", "رُ", "رَ"], "Np3lxFTKasw"),
        "ز": (["زِ", "زُ", "زَ"], "PDoV0mrK9bo"),
        "س": (["سِ", "سُ", "سَ"], "vecPcNrhKsE"),
        "ش": (["شِ", "شُ", "شَ"], "-P8YBvcWJL0"),
        "ص": (["صِ", "صُ", "صَ"], "-8kxkNwYKBs"),
        "ض": (["ضِ", "ضُ", "ضَ"], "UzZtQs_3NVg"),
        "ط": (["طِ", "طُ", "طَ"], "jJ8kVVnm4_U"),
        "ظ": (["ظِ", "ظُ", "ظَ"], "4JXjs_SOOn8"),
        "ع": (["عِ", "عُ", "عَ"], "k3-xa0Yan_g"),
        "غ": (["غِ", "غُ", "غَ"], "JKsIAcTFkQs"),
        "ف": (["فِ", "فُ", "فَ"], "LWugsK5lrks"),
        "ق": (["قِ", "قُ", "قَ"], "rZBDVQVKiOY"),
        "ك": (["كِ", "كُ", "كَ"], "1Ch9d5_BTgs"),
        "ل": (["لِ", "لُ", "لَ"], "68AEYM9H8Nw"),
        "م": (["مِ", "مُ", "مَ"], "a1YTd2ZHKI8"),
        "ن": (["نِ", "نُ", "نَ"], "Z-bHV5EuzUE"),
        "هـ": (["هِـ", "هُـ", "هَـ"], "M9n3qsQW_CQ"),
        "و": (["وِ", "وُ", "وَ"], "9ytJLcRGzpc"),
        "ي": (["يِ", "يُ", "يَ"], "oG-ZOdqsctY")
    ]
    
    
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
            correctOption: "راكون",
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

    
    
    var body: some View {
        ZStack {
            
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {

                HStack(spacing: 12) {
                    ZStack {
                        Circle()
           .stroke(Color(red: 0.20, green: 0.50, blue: 0.90), lineWidth: 6)
            .frame(width: 60, height: 60)

      Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(red: 0.20, green: 0.50, blue: 0.90))
                    }
                    
                    Text("name")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(Color(red: 0.85, green: 0.27, blue: 0.16))
                    
                    Spacer()
                }
                .padding(.top, 40)

                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(letterImages, id: \.self) { imageName in
                            
                            if let data = letterData[imageName] {
                                let lettersForCard = data.0
                                let videoID = data.1
                                let allSentences = (letterSentences[imageName] ?? []).flatMap { $0 }//wed I put it there so it could move within the arrays from level 0 to 2
//                                let allStories =(letterStories[imageName] ?? []).flatMap { $0 }
                                
                                NavigationLink {
                                    VideoPage(
                                        letters: lettersForCard,
                                        videoID: videoID,
                                        // Pass only the sentence level (index 2)
//                                        sentences: (letterSentences[imageName]?[0]) ?? []//cuz
                                        sentences: allSentences//wed cuz  the levels go to the next page
                                    )
                                } label: {
                                    Image(imageName)
                                        .resizable()
                                        .frame(width: 269, height: 103)
                                        .clipped()
                                }
                                .buttonStyle(.plain)
                                // ✅ إضافة 2: لما الطفل يضغط على الكرت، نخزن الحرف المختار
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        selectedLetter = imageName
                                    }
                                )

                            } else {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 269, height: 103)
                                    .clipped()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 60)
                }

                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    d()
}
