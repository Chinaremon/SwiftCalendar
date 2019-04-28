//
//  MonthViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

final class MonthDateManager {
    
    var didSelectDate: ((Date) -> ())?

    var selectedDate: Date = Date() {
        didSet {
            hilightModel(for: selectedDate)
            didSelectDate?(selectedDate)
        }
    }
    // ViewModel
    func hilightModel(for date: Date) {
        for i in 0..<models.count {
            if let day = days[i] {
                if day.string(format: "yyyymmdd") == date.string(format: "yyyymmdd") {
                    models[i].shouldHilight = true
                } else {
                    models[i].shouldHilight = false
                }
            } else {
                 models[i].shouldHilight = false
            }
        }
    }
    
    func goToNextDay() {
        let nextDay = Calendar.current.date(byAdding: .day
            , value: 1, to: selectedDate)!
        if Calendar.current.compare(nextDay, to: selectedDate, toGranularity: .month).rawValue == 1 {
            nextMonth()
        }
        selectedDate = nextDay
    }
    
    func goToPrevDay() {
        let prevDay = Calendar.current.date(byAdding: .day
            , value: -1, to: selectedDate)!
        
        if Calendar.current.compare(prevDay, to: selectedDate, toGranularity: .month).rawValue == -1 {
            prevMonth()
        }
        selectedDate = prevDay
    }
    
    func goToNextMonth() {
        nextMonth()
        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)!
    }
    
    func goBackToPrevMonth() {
        prevMonth()
        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)!
    }
    //
    private let calendar = Calendar.current
    private (set) var days: [Date?] = []
    private (set) var firstDate: Date! {
        didSet {
            days = generateDays()
            models = days.map { ($0 != nil) ? DayCell.Model(date: $0!) : DayCell.Model.init()  }
        }
    }
    
    var models: [DayCell.Model] = []
    
    init() {
        var component = calendar.dateComponents([.year, .month], from: Date())
        component.day = 1
        firstDate = calendar.date(from: component)
        days = generateDays()
    }
    
    func generateDays() -> [Date?] {
        // 月の初日の曜日
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        // 月の日数
        let dayCount = calendar.range(of: .day, in: .month, for: firstDate)!.count
        // 月の週の数
        let weakCount = calendar.range(of: .weekOfMonth, in: .month, for: firstDate)!.count
        
        let numberOfItems = weakCount * 7
        
        return (0..<numberOfItems).map { i in
            if (0..<dayCount).contains(i-dayOfTheWeek) {
                var dateComponents = DateComponents()
                dateComponents.day = i - dayOfTheWeek
                let date = calendar.date(byAdding: dateComponents, to: firstDate)!
                return date
            } else {
                return nil
            }
        }
    }
    
    func nextMonth() {
        firstDate = calendar.date(byAdding: .month, value: 1, to: firstDate)
    }
    
    func prevMonth() {
        firstDate = calendar.date(byAdding: .month, value: -1, to: firstDate)
    }
}

