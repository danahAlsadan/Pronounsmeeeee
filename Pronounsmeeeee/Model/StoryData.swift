//
//  StoryData.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 21/06/1447 AH.
//

import Foundation

// MARK: - Model
struct StoryItem {
    let storyLine: String
    let options: [String]
    let correctOption: String
    let imageName: String
}

// MARK: - Stories Data (Shared Model)
let allStories: [String: StoryItem] = [

    "أ": StoryItem(
        storyLine: "ذهب احمد الى حديقة الحيوان ورأى",
        options: ["أسد", "ثعلب", "جمل"],
        correctOption: "أسد",
        imageName: "أسد"
    ),

    "ب": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["بطة", "فيل", "تمساح"],
        correctOption: "بطة",
        imageName: "بطة"
    ),

    "ت": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["خروف", "تمساح", "أرنب"],
        correctOption: "تمساح",
        imageName: "تمساح"
    ),

    "ث": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ثعلب", "قرد", "صقر"],
        correctOption: "ثعلب",
        imageName: "ثعلب"
    ),

    "ج": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["لبوه", "عصفور", "جمل"],
        correctOption: "جمل",
        imageName: "جمل"
    ),

    "ح": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["زرافة", "حصان", "ذئب"],
        correctOption: "حصان",
        imageName: "حصان"
    ),

    "خ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["خروف", "نحل", "صقر"],
        correctOption: "خروف",
        imageName: "خروف"
    ),

    "د": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["نمر", "دب", "يمامة"],
        correctOption: "دب",
        imageName: "دب"
    ),

    "ذ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["ذئب", "بطة", "سمكة"],
        correctOption: "ذئب",
        imageName: "ذئب"
    ),

    "ر": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["عصفور", "راكون", "فيل"],
        correctOption: "راكون",
        imageName: "راكون"
    ),

    "ز": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["زرافة", "غوريلا", "عصفور"],
        correctOption: "زرافة",
        imageName: "زرافة"
    ),

    "س": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["كلب", "غزال", "سلحفاة"],
        correctOption: "سلحفاة",
        imageName: "سلحفاة"
    ),

    "ش": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["شجرة", "شمس", "شاي"],
        correctOption: "شجرة",
        imageName: "شجرة"
    ),

    "ص": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["صقر", "ظبي", "ماعز"],
        correctOption: "صقر",
        imageName: "صقر"
    ),

    "ض": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["كلب", "ثور", "ضفدع"],
        correctOption: "ضفدع",
        imageName: "ضفدع"
    ),

    "ط": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["نمر", "طاووس", "أسد"],
        correctOption: "طاووس",
        imageName: "طاووس"
    ),

    "ظ": StoryItem(
        storyLine: "ذهب احمد الى الحديقة ورأى",
        options: ["غوريلا", "ظبي", "زرافة"],
        correctOption: "ظبي",
        imageName: "ظبي"
    ),

    "ع": StoryItem(
        storyLine: "أحمد رأى في السماء",
        options: ["عصفور", "عين", "عنب"],
        correctOption: "عصفور",
        imageName: "عصفور"
    ),

    "غ": StoryItem(
        storyLine: "أحمد نظر إلى السماء فشاهد",
        options: ["غيمة", "غراب", "غطاء"],
        correctOption: "غيمة",
        imageName: "غيمة"
    ),

    "ف": StoryItem(
        storyLine: "أحمد ذهب إلى الحديقة الكبيرة وشاهد",
        options: ["فيل", "فأر", "فم"],
        correctOption: "فيل",
        imageName: "فيل"
    ),

    "ق": StoryItem(
        storyLine: "أحمد نظر إلى السماء فرأى",
        options: ["قمر", "قلم", "قطة"],
        correctOption: "قمر",
        imageName: "قمر"
    ),

    "ك": StoryItem(
        storyLine: "أحمد شرب الماء من",
        options: ["كوب", "كتاب", "كرسي"],
        correctOption: "كوب",
        imageName: "كوب"
    ),

    "ل": StoryItem(
        storyLine: "أحمد لعب بـ",
        options: ["لعبة", "لبن", "لؤلؤ"],
        correctOption: "لعبة",
        imageName: "لعبة"
    ),

    "م": StoryItem(
        storyLine: "أحمد أكل",
        options: ["موز", "ماء", "ملح"],
        correctOption: "موز",
        imageName: "موز"
    ),

    "ن": StoryItem(
        storyLine: "أحمد شاهد في الغابة",
        options: ["نمر", "نار", "نملة"],
        correctOption: "نمر",
        imageName: "نمر"
    ),

    "هـ": StoryItem(
        storyLine: "أحمد رأى في السماء",
        options: ["هلال", "هر", "هدهد"],
        correctOption: "هلال",
        imageName: "هلال"
    ),

    "و": StoryItem(
        storyLine: "أحمد شم رائحة",
        options: ["ورد", "وجه", "ورق"],
        correctOption: "ورد",
        imageName: "ورد"
    ),

    "ي": StoryItem(
        storyLine: "أحمد رأى طائرًا جميلًا هو",
        options: ["يمامة", "يد", "يوم"],
        correctOption: "يمامة",
        imageName: "يمامة"
    )
]
