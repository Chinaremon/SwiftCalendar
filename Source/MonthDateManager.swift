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
            updateModel()
        }
    }
    
    var models: [DayCell.Model] = []
    
    init() {
        var component = calendar.dateComponents([.year, .month], from: Date())
        component.day = 1
        firstDate = calendar.date(from: component)
        updateModel()
    }
    
    func updateModel() {
        days.removeAll()
        // 月の初日の曜日
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        // 月の日数
        let dayCount = calendar.range(of: .day, in: .month, for: firstDate)!.count
        
        let weakCount = calendar.range(of: .weekOfMonth, in: .month, for: firstDate)!.count
        
        let numberOfItems = weakCount * 7
        
        (0..<numberOfItems).forEach { i in
            if (0..<dayCount).contains(i-dayOfTheWeek) {
                var dateComponents = DateComponents()
                dateComponents.day = i - dayOfTheWeek
                let date = calendar.date(byAdding: dateComponents, to: firstDate)!
                days.append(date)
            } else {
                days.append(nil)
            }
        }
        
        models = days.map { ($0 != nil) ? DayCell.Model(date: $0!) : DayCell.Model.init()  }
    }
    
    func nextMonth() {
        firstDate = calendar.date(byAdding: .month, value: 1, to: firstDate)
    }
    
    func prevMonth() {
        firstDate = calendar.date(byAdding: .month, value: -1, to: firstDate)
    }
}

