//
//  ViewModel.swift
//  Calender
//
//  Created by chutatsu on 2019/04/29.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

protocol MonthDateManagerDelegate: AnyObject {
    func title(_ title: String)
    func selectedDate(_ date: Date)
}

final class CalendarViewModel {
    
    weak var bindDelegate: MonthDateManagerDelegate? {
        didSet {
            // 初期値を流す
            bindDelegate?.title(title)
            bindDelegate?.selectedDate(selectedDate)
        }
    }
    
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
    
    init(day: Date) {
        selectedDate = day
        updateDayAndModels(for: day)
        hilightModel(for: selectedDate)
        title = selectedDate.string(format: "yyyy/MM/dd")
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
