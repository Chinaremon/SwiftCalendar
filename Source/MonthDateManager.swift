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
    
    var selectedDate = Date() {
        didSet {
            if !dateManager.isEqualMonth(selectedDate, to: oldValue) {
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
                if dateManager.isEqual(day, to: date){
                    models[i].shouldHilight = true
                    break
                }
            }
        }
    }
    
    // Input
    
    func goToNextDay() {
        selectedDate = dateManager.nextDay(of: selectedDate)
    }
    
    func goToPrevDay() {
        selectedDate = dateManager.prevDay(of: selectedDate)
    }
    
    func goToNextMonth() {
        selectedDate = dateManager.nextMonth(of: selectedDate)
    }
    
    func goBackToPrevMonth() {
        selectedDate = dateManager.prevMonth(of: selectedDate)
    }
    
    func selectDate(at indexPath: IndexPath) {
        if let date = days[indexPath.row] {
            selectedDate = date
        }
    }
}


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
