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
    
    let letterImages: [String] = [
        "أ", "ب", "ت", "ث", "ج", "ح", "خ",
        "د", "ذ", "ر", "ز", "س", "ش", "ص",
        "ض", "ط", "ظ", "ع", "غ", "ف", "ق",
        "ك", "ل", "م", "ن", "هـ", "و", "ي"
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

                                NavigationLink {
                                    VideoPage(
                                        letters: lettersForCard,
                                        videoID: videoID,
                                        sentences: []
                                    )
                                } label: {
                                    Image(imageName)
                                        .resizable()

                                        .frame(width: 269, height: 103)
                                        .clipped()
                                }
                                .buttonStyle(.plain)

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
