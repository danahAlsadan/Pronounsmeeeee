import SwiftUI
//import ConfettiSwiftUI

struct RecorderView: View {
    @StateObject var recognizer = SpeechRecognizer()
//    let db = SQLiteManager()
    @AppStorage("selectedLetter") private var selectedLetter: String = ""

    @State private var goToStory = false
    @State private var goToHomepage = false

    @State var sentences: [String]

    // جمل الحروف
    let letterSentences: [String: [String]] = [
        "أ": ["أرنب", "أسد", "أذن"],
        "ب": ["باب", "برتقال", "بطة"],
        "ت": ["تمر", "تفاحة", "توت"],
        // كملي بقية الحروف بنفس الشكل...
    ]

    @State private var currentIndex = 0
    @State private var confettiCounter = 0
    @State private var isRecording = false
    
    @State private var resultMessage = ""
    @State private var showNextButton = false

    // Read saved child info for HomePage navigation
    private var storedChildName: String {
        UserDefaults.standard.string(forKey: "childName") ?? ""
    }
    private var storedProfileImage: String {
        UserDefaults.standard.string(forKey: "profileImage") ?? "Boy"
    }
    
    // تقدم الجمل في هذه الجلسة
    private var completedSentences: Int { currentIndex }
    private var totalSentences: Int { sentences.count }
    
    var targetWord: String {
        sentences[currentIndex]
    }
    
    var body: some View {
        ZStack {
            
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                 Spacer().frame(height: 100) // نفس المسافة في صفحة الفيديو
                 HStack {
                     Spacer() // يدفع الزر لليمين
                     Button(action: {
                         goToHomepage = true
                     }) {
                         Image(systemName: "house")
                             .foregroundColor(Color(hex: "f6b922"))
                             .font(.title)
                             .frame(width: 60, height: 60)
                             .background(
                                 RoundedRectangle(cornerRadius: 16)
                                     .fill(Color.white.opacity(0.6))
                             )
                     }
                     .padding(.top, -110)
                     .padding(.trailing, 50)
                 }
                 Spacer()
             }

             NavigationLink(
                 destination: HomePage(
                     childName: storedChildName,
                     profileImage: storedProfileImage
                 ),
                 isActive: $goToHomepage
             ) {
                 EmptyView()
             }
            
            
            
            NavigationLink(
                destination: AnimalQuizView(letter: selectedLetter), // هنا نمرر الحرف المختار
                isActive: $goToStory
            ) {
                EmptyView()
            }
            .hidden()

            VStack(spacing: 30) {
                
                Spacer()
//                Text( "اقراء التالي :")
//                .foregroundColor(.gray)


                //المربع الأبيض للكلمة
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white.opacity(0.85))
                    .frame(width: 350, height: 520)
                    .opacity(0.60)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 4)

                
                    .overlay(
                        VStack(spacing: 20) {
                            
                            Text("اقرأ التالي :")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .medium))

                            Text(targetWord)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.gray)
                            
                            
                           
                            
                            
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
                                .foregroundColor(.gray)

                            
                            
                            
                            
                            Text("انت قلت:")
                            .foregroundColor(.gray)

                            Text(recognizer.transcript)
                                .foregroundColor(.gray)
                            
                            
                            Text("\(completedSentences)/\(totalSentences)")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .offset(y: 30)

                        }
                    )

//                Text("\(completedSentences)/\(totalSentences)")
//                    .font(.title3)
//                    .foregroundColor(.gray)

                
//                Button(action: {
//                    toggleRecording()
//                }) {
//                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
//                        .font(.system(size: 70))
//                        .foregroundColor(.white)
//                        .frame(width: 150, height: 150)
//                        .background(
//                            RoundedRectangle(cornerRadius: 30)
//                                .fill(Color(hex: "f6b922").opacity(0.90))
//                        )
//                        .shadow(color: .black.opacity(0.25), radius: 8, y: 5)
//                }
//                
//                //  النتيجة
//                Text(resultMessage)
//                    .font(.system(size: 40))
//                    .foregroundColor(.gray)
//
//                
//                
//                
//                
//                Text("انت قلت:")
//                .foregroundColor(.gray)
//
//                Text(recognizer.transcript)
//                    .foregroundColor(.gray)
             
                
                // زر التالي
//                if showNextButton {
//                    Button(action: { nextSentence() })
//                    {
//                        Text("التالي")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .frame(width: 195, height: 42)
//                            .background(Color(hex: "f6b922"))
//                            .cornerRadius(25)
//                    }
//                }
//
                if showNextButton {
                    Button(action: {
                        if currentIndex == sentences.count - 1 {
                            goToStory  = true   // ← يروح للصفحة الثانية
                        } else {
                            nextSentence()
                        }
                    }) {
                        Text(currentIndex == sentences.count - 1 ? "إنهاء" : "التالي")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 195, height: 42)
                            .background(Color(hex: "f6b922"))
                            .cornerRadius(25)
                    }
                }
//                Button(action: {
//                    goToStory = true
//                    }) {
//                        Text("القصة (مؤقت)")
//                            .font(.title3)
//                            .foregroundColor(.white)
//                            .frame(width: 200, height: 42)
//                            .background(Color.blue.opacity(0.8))
//                            .cornerRadius(25)
//                    }

                Spacer()
            }
            .padding(.bottom, 30)
            
//            ConfettiCannon(trigger: $confettiCounter)
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    //  تسجيل الصوت
    func toggleRecording() {
        if isRecording {
            // المستخدم ضغط لإيقاف المايك يدويًا
            stopRecording()
        } else {
            // المستخدم ضغط لبدء التسجيل
            recognizer.start()
            resultMessage = ""
            showNextButton = false
            isRecording = true

            // إيقاف تلقائي بعد 5 ثواني إذا المستخدم ما أوقف المايك
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if isRecording {
                    stopRecording()
                }
            }

        }
    }

    func stopRecording() {
        if !isRecording { return } // حماية من التوقف المكرر
        isRecording = false
        recognizer.stop()
        checkWord() // قارن الكلمة بعد الإيقاف
    }

    
    // التحقق من الكلمة
//    func checkWord() {
//        let spoken = recognizer.transcript.trimmingCharacters(in: .whitespaces)
//        
//        if spoken.contains(targetWord) {
//            resultMessage = "😁"
//            db.insert(word: targetWord, correct: true)
//            showNextButton = false
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                showNextButton = true
//            }
//        } else {
//            resultMessage = "😕"
//            db.insert(word: targetWord, correct: false)
//        }
//    }
    
    
    func normalize(_ text: String) -> String {
        return text
            .applyingTransform(.stripCombiningMarks, reverse: false)?
            .replacingOccurrences(of: "‌", with: "") // remove invisible
            .replacingOccurrences(of: " ", with: "") // remove spaces
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() ?? text.lowercased()
    }
//
    func checkWord() {
        let spoken = normalize(recognizer.transcript)
        let target = normalize(targetWord)

        if spoken.contains(target) {
            resultMessage = "😁"
//            db.insert(word: targetWord, correct: true)
            showNextButton = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showNextButton = true
            }
        } else {
            resultMessage = "😕"
//            db.insert(word: targetWord, correct: false)
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
            
            
            UserDefaults.standard.set(currentIndex + 1, forKey: "progress_\(selectedLetter)")

        } else {
//            resultMessage = "👏 خلصت كل الجمل!"
//            showNextButton = false
            confettiCounter += 1
            showNextButton = true         }
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
    RecorderView(sentences: ["باب", "برتقال", "بطة",])
}
