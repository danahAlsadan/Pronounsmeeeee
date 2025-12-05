import SwiftUI
import ConfettiSwiftUI

struct RecorderView: View {
    @StateObject var recognizer = SpeechRecognizer()
    let db = SQLiteManager()
    
    @State private var sentences = [
        "ذهب أحمد إلى الحديقة",
        "لعب خالد بالكرة",
        "ذهبت مريم إلى المدرسة",
        "ركب سالم الدراجة"
    ]
    
    @State private var currentIndex = 0
    @State private var confettiCounter = 0
    @State private var isRecording = false
    
    @State private var resultMessage = ""
    @State private var showNextButton = false
    
    var targetWord: String {
        sentences[currentIndex]
    }
    
    var body: some View {
        ZStack {
            
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Spacer()
                
                //المربع الأبيض للكلمة
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.85))
                    .frame(width: 300, height: 120)
                    .opacity(0.60)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 4)

                    .overlay(
                        Text(targetWord)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                            
                    )
                
                
                Button(action: {
                    toggleRecording()
                }) {
                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "f6b922").opacity(0.90))
                        )
                        .shadow(color: .black.opacity(0.25), radius: 8, y: 5)
                }
                
                //  النتيجة
                Text(resultMessage)
                    .font(.system(size: 40))
                
                
                
                
                Text("انت قلت:")
                Text(recognizer.transcript)
                    .foregroundColor(.gray)
             
                
                // زر التالي
                if showNextButton {
                    Button(action: { nextSentence() })
                    {
                        Text("التالي")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 195, height: 42)
                            .background(Color(hex: "f6b922"))
                            .cornerRadius(25)
                    }
                }
                
                Spacer()
            }
            .padding(.bottom, 30)
            
            ConfettiCannon(trigger: $confettiCounter)
        }
    }
    
    //  تسجيل الصوت
    func toggleRecording() {
        if isRecording {
            recognizer.stop()
            checkWord()
        } else {
            recognizer.start()
        }
        isRecording.toggle()
    }
    
    // التحقق من الكلمة
    func checkWord() {
        let spoken = recognizer.transcript.trimmingCharacters(in: .whitespaces)
        
        if spoken.contains(targetWord) {
            resultMessage = "😁"
            db.insert(word: targetWord, correct: true)
            showNextButton = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showNextButton = true
            }
        } else {
            resultMessage = "😕"
            db.insert(word: targetWord, correct: false)
        }
    }
    
    // الانتقال للجملة التالية
    func nextSentence() {
        if currentIndex < sentences.count - 1 {
            currentIndex += 1
            recognizer.transcript = ""
            resultMessage = ""
            showNextButton = false
            isRecording = false
        } else {
//            resultMessage = "👏 خلصت كل الجمل!"
            showNextButton = false
            confettiCounter += 1
        }
    }
}




//  دعم كتابة ألوان hex
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    RecorderView()
}
