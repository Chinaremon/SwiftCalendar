//
//  CalenderView.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

protocol CalenderViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

final class CalenderView: BaseView {

    weak var delegate: CalenderViewDelegate?

    private let topView = TopView()
    private let weekView = WeekDayView()
    private (set) lazy var monthGridView: MonthGridView = {
        let it = MonthGridView(dateManager: dateManager)
        it.delegate = self
        return it
    }()

    private let dateManager = MonthDateManager()
    
    var selectedDate: Date = Date() {
        didSet {
            topView.setTitle(selectedDate.string(format: "yyyy/MM/dd"))
            monthGridView.hilightDate(selectedDate)
            delegate?.didSelectDate(selectedDate)
        }
    }

    override func initializeView() {
        topView.delegate = self
        addSubview(topView)
        addSubview(weekView)
        addSubview(monthGridView)
        addSwipeGesture()
    }
    
    override func initializeConstraints() {
        topView.chura.layout.top(0).left(0).right(0).height(Style.topViewHeight)
        weekView.chura.layout
            .left(0).top(topView.bottomAnchor).height(Style.weekViewHeight).right(0)
        monthGridView.chura.layout
            .top(weekView.bottomAnchor).left(0)
            .right(0).bottom(0)
    }
    
    private func addSwipeGesture() {
        [UISwipeGestureRecognizer.Direction.right, .left].forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipe))
            swipe.direction = $0
            monthGridView.addGestureRecognizer(swipe)
        }
    }

    @objc private func actionSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            goToNextDay()
        } else if sender.direction == .right {
            // go back to prev day
            goBackPrevDay()
        }
    }
    
    private func goToNextDay() {
        let nextDay = Calendar.current.date(byAdding: .day
            , value: 1, to: selectedDate)!
        if Calendar.current.compare(nextDay, to: selectedDate, toGranularity: .month).rawValue == 1 {
            dateManager.nextMonth()
            monthGridView.reloadData()
        
            // 最初に印をつける
            for i in 0..<dateManager.days.count {
                if let _ = dateManager.days[i] {
                    dateManager.models[i].shouldHilight = true
                    break
                }
            }
        }
        selectedDate = nextDay
    }
    
    private func goBackPrevDay() {

        let prevDay = Calendar.current.date(byAdding: .day
            , value: -1, to: selectedDate)!

        if Calendar.current.compare(prevDay, to: selectedDate, toGranularity: .month).rawValue == -1 {
            dateManager.prevMonth()
            monthGridView.reloadData()
            // 最初に印をつける
            for i in 0..<dateManager.days.count {
                let lastIndex = dateManager.days.count - 1
                if let _ = dateManager.days[lastIndex - i] {
                    dateManager.models[lastIndex - i].shouldHilight = true
                    break
                }
            }
        }
        selectedDate = prevDay
    }
}

extension CalenderView: TopViewDelegate {
    
    func didTapBack() {
        dateManager.prevMonth()
        monthGridView.reloadData()
        topView.setTitle(dateManager.yyyymmString)
    }
    
    func didTapNext() {
        dateManager.nextMonth()
        monthGridView.reloadData()
        topView.setTitle(dateManager.yyyymmString)
    }
}

extension CalenderView: MonthGridViewDelegate {
    
    func didSelectDate(at indexPath: IndexPath) {
        if let date = dateManager.days[indexPath.row] {
            selectedDate = date
        }
    }
    
    func hoge() {
        monthGridView.hilightDate(dateManager.firstDate)
    }
}



