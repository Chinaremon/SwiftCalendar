//
//  MonthViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

final class MonthDateManager {
    
    var yyyymmString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM"
        return formatter.string(from: firstDate)
    }
    
    private let calendar = Calendar.current
    private (set) var days: [Date?] = []
    private (set) var firstDate: Date! {
        didSet {
            updateModel()
        }
    }
    
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
    }
    
    func nextMonth() {
        firstDate = calendar.date(byAdding: .month, value: 1, to: firstDate)
    }
    
    func prevMonth() {
        firstDate = calendar.date(byAdding: .month, value: -1, to: firstDate)
    }
}

