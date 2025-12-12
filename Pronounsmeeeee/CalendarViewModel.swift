//
//  CalendarViewModel.swift
//  Pronounsmeeeee
//
//  Created by danah alsadan on 21/06/1447 AH.
//

import Foundation
import SwiftUI
import Combine

final class CalendarViewModel: ObservableObject {

    @Published var currentMonth: Date = Date()

    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    func getMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }

    func moveMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newDate
        }
    }

    func getDaysArray() -> [DayInfo?] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        guard
            let interval = calendar.dateInterval(of: .month, for: currentMonth),
            let weekday = calendar.dateComponents([.weekday], from: interval.start).weekday,
            let daysCount = calendar.range(of: .day, in: .month, for: currentMonth)?.count
        else {
            return []
        }

        let offset = weekday == 1 ? 6 : weekday - 2
        var result: [DayInfo?] = Array(repeating: nil, count: offset)

        for day in 1...daysCount {
            if let date = calendar.date(bySetting: .day, value: day, of: currentMonth) {
                let dayDate = calendar.startOfDay(for: date)

                let isToday = dayDate == today
                let isPast  = dayDate < today
                let isFuture = dayDate > today

                result.append(
                    DayInfo(day: day, isToday: isToday, isPast: isPast, isFuture: isFuture)
                )
            }
        }

        return result
    }
}
