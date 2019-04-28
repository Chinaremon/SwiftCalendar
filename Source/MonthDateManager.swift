//
//  MonthViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation


protocol MonthDateManagerDelegate: AnyObject {
    func models()
    func title(_ title: String)
    func selectedDate(_ date: Date)
}

final class MonthDateManager {
    
    weak var bindDelegate: MonthDateManagerDelegate?
    
    private let dateManager = DateManager()
    private var days: [Date?] = []
    private (set) var models: [DayCell.Model] = []
    private let calendar = Calendar.current

    private var title = "" {
        didSet { bindDelegate?.title(title)}
    }

    private var selectedDate = Date() {
        didSet {
            if calendar.compare(oldValue, to: selectedDate, toGranularity: .month).rawValue != 0 {
                updateDayAndModels(for: selectedDate)
            }
            hilightModel(for: selectedDate)
            title = selectedDate.string(format: "yyyy/MM/dd")
            bindDelegate?.selectedDate(selectedDate)
        }
    }
    
    private func updateDayAndModels(for date: Date) {
        days = dateManager.generateMonthDays(for: date)
        models = days.map { ($0 != nil) ? DayCell.Model(date: $0!) : DayCell.Model.init()  }
    }

    private func hilightModel(for date: Date) {
        (0..<models.count).forEach { models[$0].shouldHilight = false }
        for i in 0..<models.count {
            if let day = days[i] {
                if day.string(format: "yyyyMMdd") == date.string(format: "yyyyMMdd") {
                    models[i].shouldHilight = true
                    break
                }
            }
        }
    }
    
    // Input
    
    func goToNextDay() {
        let nextDay = Calendar.current.date(byAdding: .day
            , value: 1, to: selectedDate)!
        selectedDate = nextDay
    }
    
    func goToPrevDay() {
        let prevDay = Calendar.current.date(byAdding: .day
            , value: -1, to: selectedDate)!
        selectedDate = prevDay
    }
    
    func goToNextMonth() {
        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)!
    }
    
    func goBackToPrevMonth() {
        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)!
    }
    
    func selectDate(at indexPath: IndexPath) {
        if let date = days[indexPath.row] {
            selectedDate = date
        }
    }
}


struct DateManager {
    
    private let calendar = Calendar.current

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
