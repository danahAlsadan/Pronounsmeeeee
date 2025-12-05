//
//  Untitled.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 13/06/1447 AH.
//

import SwiftUI
import WebKit

// MARK: - Video WebView
struct YouTubeVideoView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        // إذا كنا في PREVIEW → رجّع WebView فاضي
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return WKWebView()   // بدون تحميل فيديو
        }
        #endif
        
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return    // لا يحمل فيديو في Preview
        }
        #endif
        
        let embedURL = "https://www.youtube.com/embed/\(videoID)?playsinline=1"
        if let url = URL(string: embedURL) {
            uiView.load(URLRequest(url: url))
        }
    }
}

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
        ZStack {
            
            // الخلفية الحقيقة → لا تظهر في Preview
            #if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                Image("خلفيتي")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            #else
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            #endif
            
            VStack {
                Spacer().frame(height: 140)

                // الحروف
                HStack(spacing: 55) {
                    ForEach(letters, id: \.self) { letter in
                        Text(letter)
                    }
                }
                .font(.system(size: 47, weight: .medium))
                .foregroundColor(Color(red: 241/255, green: 176/255, blue: 0/255))
                
                Spacer().frame(height: 150)

                // YouTube video
                YouTubeVideoView(videoID: videoID)
                    .frame(width: 350, height: 190)
                    .cornerRadius(24)
                    .shadow(radius: 3)
                
                Spacer().frame(height: 400)
            }
        }
    }
}

#Preview {
    VideoPage(
        letters: ["أِ", "أُ", "أَ"],
        videoID: "biWQsbDq5O0",
        sentences: ["Up", "Arm", "Yes"]
    )
}
