//
//  MonthViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

struct DateManager {
    
    private let calendar = Calendar.current
    
    func nextDay(of date: Date) -> Date {
        return calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
    func prevDay(of date: Date) -> Date {
        return calendar.date(byAdding: .day, value: -1, to: date)!
    }
    
    func nextMonth(of date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func prevMonth(of date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func isEqual(_ date1: Date, to: Date) -> Bool {
        return date1.string(format: "yyyyMMdd") == to.string(format: "yyyyMMdd")
    }
    
    func isEqualMonth(_ date1: Date, to: Date) -> Bool {
        return calendar.compare(date1, to: to, toGranularity: .month).rawValue == 0
    }
    
    func generateMonthDays(for date: Date) -> [Date?] {
        
        var component = calendar.dateComponents([.year, .month], from: date)
        component.day = 1
        let firstDate = calendar.date(from: component)!
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
}
