//
//  PronounsmeeeeeApp.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 13/06/1447 AH.
//

import SwiftUI

@main
struct PronounsmeeeeeApp: App {
    @StateObject var calendarVM = CalendarViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()   //RootView
        }
        .environmentObject(calendarVM)

    }
}
/// dont  put any thing here plz

#Preview {
    RootView()
}
