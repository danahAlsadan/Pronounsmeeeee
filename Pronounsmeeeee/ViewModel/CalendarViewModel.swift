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
    @Published var currentStreak: Int = 0
    
    private var completedDates: Set<String> = []
    private let completedDatesKey = "completedDatesKey"
    
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let arabicMonths = [
        "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
        "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
    ]
//    func getMonthYear() -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US")
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter.string(from: currentMonth)
//    }
    func getMonthYear() -> String {
        let calendar = Calendar.current
        let monthIndex = calendar.component(.month, from: currentMonth) - 1
        let year = calendar.component(.year, from: currentMonth)
        return "\(arabicMonths[monthIndex]) \(year)"
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

        let offset = weekday - 1
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
    
    func loadCompletedDates() {
        if let savedDates = UserDefaults.standard.array(forKey: completedDatesKey) as? [String] {
            completedDates = Set(savedDates)
        }
    }
    
    func isDateCompleted(day: Int) -> Bool {
        guard let date = Calendar.current.date(bySetting: .day, value: day, of: currentMonth) else {
            return false
        }
        
        let dateStr = dateString(from: date)
        return completedDates.contains(dateStr)
    }
    
    func isPartOfStreak(day: Int) -> Bool {
        guard currentStreak >= 3 else { return false }
        
        guard let date = Calendar.current.date(bySetting: .day, value: day, of: currentMonth) else {
            return false
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayDate = calendar.startOfDay(for: date)
        
        let daysDifference = calendar.dateComponents([.day], from: dayDate, to: today).day ?? 0
        
        return daysDifference >= 0 && daysDifference < currentStreak && isDateCompleted(day: day)
    }
    
    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func calculateStreak() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var streak = 0
        
        if completedDates.contains(dateString(from: today)) {
            streak = 1
            
            for i in 1..<365 {
                guard let previousDay = calendar.date(byAdding: .day, value: -i, to: today) else {
                    break
                }
                
                if completedDates.contains(dateString(from: previousDay)) {
                    streak += 1
                } else {
                    break
                }
            }
        } else {
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
               completedDates.contains(dateString(from: yesterday)) {
                streak = 1
                
                for i in 2..<365 {
                    guard let previousDay = calendar.date(byAdding: .day, value: -i, to: today) else {
                        break
                    }
                    
                    if completedDates.contains(dateString(from: previousDay)) {
                        streak += 1
                    } else {
                        break
                    }
                }
            }
        }
        
        currentStreak = streak
    }
    
    func markTodayAsCompleted() {
        let today = Date()
        let dateStr = dateString(from: today)
        
        completedDates.insert(dateStr)
        
        UserDefaults.standard.set(Array(completedDates), forKey: completedDatesKey)
        
        calculateStreak()
    }
    
    func clearAllCompletedDates() {
        completedDates.removeAll()
        UserDefaults.standard.removeObject(forKey: completedDatesKey)
        currentStreak = 0
    }
}
