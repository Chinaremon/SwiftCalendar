//
//  MonthViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

final class MonthDateManager {
    
    // ViewModel
    
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

