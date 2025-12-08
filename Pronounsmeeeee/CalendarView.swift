
//
//  CalendarView.swift
//  Pronounsmeeeee
//

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth = Date()
    
    var onDismiss: () -> Void = {}
    
    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ZStack {
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
//                    Button {
//                        onDismiss()
//                    } label: {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.system(size: 32))
//                            .foregroundColor(.gray)
//                    }
//                    
//                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                HStack(spacing: 20) {
                    Button {
                        moveMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundColor(.yellow)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Text(getMonthYear())
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.orange)
                        .frame(minWidth: 180)
                    
                    Button {
                        moveMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24))
                            .foregroundColor(.yellow)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.vertical, 15)
                
                HStack(spacing: 0) {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                    }
                }
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .padding(.horizontal, 19)
                .padding(.bottom, 20)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 7) {
                        ForEach(getDaysArray(), id: \.self) { dayInfo in
                            if let dayInfo = dayInfo {
                                DayCell(
                                    day: dayInfo.day,
                                    isToday: dayInfo.isToday,
                                    isPast: dayInfo.isPast,
                                    isFuture: dayInfo.isFuture
                                )
                            } else {
                                Color.clear.frame(height: 69)
                            }
                        }
                    }
                    .padding(.horizontal, 29)
                    .padding(.bottom, 30)
                }
            }
        }
    }
    
    func getMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMM yyyy"
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
        
        guard let interval = calendar.dateInterval(of: .month, for: currentMonth),
              let weekday = calendar.dateComponents([.weekday], from: interval.start).weekday,
              let daysCount = calendar.range(of: .day, in: .month, for: currentMonth)?.count else {
            return []
        }
        
        let offset = weekday == 1 ? 6 : weekday - 2
        var result: [DayInfo?] = Array(repeating: nil, count: offset)
        
        for day in 1...daysCount {
            if let date = calendar.date(bySetting: .day, value: day, of: currentMonth) {
                let dayDate = calendar.startOfDay(for: date)
                
                let isToday = dayDate == today
                let isPast = dayDate < today
                let isFuture = dayDate > today
                
                result.append(DayInfo(
                    day: day,
                    isToday: isToday,
                    isPast: isPast,
                    isFuture: isFuture
                ))
            }
        }
        
        return result
    }
}

struct DayInfo: Hashable {
    let day: Int
    let isToday: Bool
    let isPast: Bool
    let isFuture: Bool
}

struct DayCell: View {
    let day: Int
    let isToday: Bool
    let isPast: Bool
    let isFuture: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(day)")
                .font(.system(size: 19))
                .foregroundColor(isToday ? .orange : .gray)
            
            if isToday {
                Image("نجمه")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            } else if isFuture {
                Image("نجمه")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .opacity(0.3)
            } else {
                Image("نجمه")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .opacity(0.6)
            }
        }
        .frame(height: 77)
        .frame(maxWidth: .infinity)
        .background(isToday ? Color.yellow.opacity(0.2) : Color.white.opacity(0.7))
        .cornerRadius(12)
    }
}

#Preview {
    CalendarView()
}
