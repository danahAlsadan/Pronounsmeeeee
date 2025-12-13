//
//  Untitled.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 13/06/1447 AH.
//


import SwiftUI

// MARK: - Video Page
struct VideoPage: View {
    let letters: [String]
    let videoID: String
    let sentences: [String]

    var body: some View {
        LetterVideoScreen(letters: letters, videoID: videoID, sentences: sentences)
    }
}

// MARK: - Letter Video Screen
struct LetterVideoScreen: View {
    
    let letters: [String]
    let videoID: String
    let sentences: [String]

    var body: some View {
        
        // رابط الفيديو لفتح Safari / YouTube
        let videoURL = URL(string: "https://youtu.be/\(videoID)")!
        // رابط صورة الفيديو (Thumbnail)
        let thumbnailURL = URL(string: "https://img.youtube.com/vi/\(videoID)/hqdefault.jpg")!
        
        ZStack {
            
            // الخلفية
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 140)
                
                // الحروف بالحركات
                HStack(spacing: 55) {
                    ForEach(letters, id: \.self) { letter in
                        Text(letter)
                    }
                }
                .font(.system(size: 47, weight: .medium))
                .foregroundColor(Color(red: 241/255, green: 176/255, blue: 0/255))
                
                Spacer().frame(height: 150)
                
                // مربع الفيديو (ثابت من أول لحظة) + صورة الفيديو لما تجهز
                Button {
                    UIApplication.shared.open(videoURL)
                } label: {
                    ZStack {
                        // خلفية ثابتة تظهر من أول لحظة
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 350, height: 190)
                            .shadow(radius: 3)
                        
                        // صورة الفيديو من YouTube (بدون دائرة تحميل)
                        AsyncImage(url: thumbnailURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            // ما نعرض تحميل، نخلي الخلفية فقط
                            Color.clear
                        }
                        .frame(width: 350, height: 190)
                        .clipped()
                        .cornerRadius(24)
                        
                        // أيقونة التشغيل فوق الصورة
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                }
                .buttonStyle(.plain)
                
                //دانه الزر خليته كوميت لانه اذا اضفته الخلفيه تنزل تحت شوي   بشوف سالفتها  بعدين
                Spacer().frame(height: 300)
            }
            
            HStack{
                //wed    button to go to the next page mic
                NavigationLink {
                    RecorderView(sentences: sentences)
                } label: {
                    Text("التمارين")
                        .font(.title2)
                        .foregroundColor(.white)
//                        .padding()
//                        .frame(width: 220)
//                        .background(Color(hex: "f6b922"))
//                        .cornerRadius(20)
                        .offset(y: -10)

                    
                  
                    
                    Image(systemName: "arrowshape.right.fill")
                                .foregroundColor(.white)
                                .font(.title3)
                                .offset(y: -10)

                }
                
                .padding(.top, 20)
                .buttonStyle(.plain)
                .shadow(radius: 2)
                .padding()
                .frame(width: 220 , height: 70)
                .background(Color(hex: "f6b922"))
                .cornerRadius(20)
            }
            .padding(.top, 500)
////
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    VideoPage(
        letters: ["أِ", "أُ", "أَ"],
        videoID: "biWQsbDq5O0",
        sentences: ["Up", "Arm", "Yes"]
    )
}
