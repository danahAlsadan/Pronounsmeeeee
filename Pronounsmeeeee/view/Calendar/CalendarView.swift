//
//  CalendarView.swift
//  Pronounsmeeeee
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var showStreakPopup = false
    
    var onDismiss: () -> Void = {}
    
    private let weekdays = ["أحد", "أثنين", "ثلاثاء", "اربعاء", "خميس", "جمعة", "سبت"]
    
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
                        viewModel.moveMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundColor(.yellow)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Text(viewModel.getMonthYear())
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.orange)
                        .frame(minWidth: 180)
                    
                    Button {
                        viewModel.moveMonth(by: 1)
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
                        ForEach(viewModel.getDaysArray(), id: \.self) { dayInfo in
                            if let dayInfo = dayInfo {
                                DayCell(
                                    day: dayInfo.day,
                                    isToday: dayInfo.isToday,
                                    isPast: dayInfo.isPast,
                                    isFuture: dayInfo.isFuture,
                                    isCompleted: viewModel.isDateCompleted(day: dayInfo.day),
                                    isPartOfStreak: viewModel.isPartOfStreak(day: dayInfo.day)
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
            
            // Pop-up للـ Streak - مربع
            if showStreakPopup && viewModel.currentStreak >= 3 {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showStreakPopup = false
                            }
                        }
                    
                    VStack(spacing: 15) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                            .symbolEffect(.pulse)
                        
                        Text("\(viewModel.currentStreak)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.orange)
                        
                        Text("أيام متتالية!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.orange)
                        
                        Text("استمر في التمرين 💪")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
          //
                        Button {
                            withAnimation {
                                showStreakPopup = false
                            }
                        } label: {
                            Text("رائع!")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(Color.orange)
                                )
                        }
                    }
                    .padding(30)
                    .frame(width: 280, height: 280)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(radius: 20)
                    )
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
        }
        .onAppear {
            viewModel.loadCompletedDates()
            viewModel.calculateStreak()
            
            // إظهار الـ Pop-up إذا فيه streak
            if viewModel.currentStreak >= 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring()) {
                        showStreakPopup = true
                    }
                }
            }
        }
    }
}

struct DayCell: View {
    let day: Int
    let isToday: Bool
    let isPast: Bool
    let isFuture: Bool
    let isCompleted: Bool
    let isPartOfStreak: Bool
    
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
                    .opacity(isCompleted ? 0.6 : 0.6)
            }
        }
        .frame(height: 77)
        .frame(maxWidth: .infinity)
        .background(isToday ? Color.yellow.opacity(0.2) : Color.white.opacity(0.7))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPartOfStreak ? Color.yellow : Color.clear, lineWidth: 3)
        )
        .scaleEffect(isToday ? 1.1 : 1.0)
        .shadow(color: isToday ? Color.orange.opacity(0.4) : Color.clear, radius: 8, y: 4)
    }
}

#Preview {
    CalendarView()
}
