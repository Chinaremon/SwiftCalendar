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

    private lazy var monthGridView: MonthGridView = {
        let it = MonthGridView(viewModel: viewModel)
        it.delegate = self
        return it
    }()
    
    private var viewModel = CalendarViewModel(day: Date())
    
    override func initializeView() {
        topView.delegate = self
        addSubview(topView)
        addSubview(weekView)
        addSubview(monthGridView)
        addSwipeGesture()
        // NOTE: monthGridViewを参照するのでmonthGridViewの初期化後にセット
        // 多分 monthGridViewにはモデルだけ参照してあげれば良い。
        viewModel.bindDelegate = self
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
            viewModel.goToNextDay()
        } else if sender.direction == .right {
            viewModel.goToPrevDay()
        }
    }
}

extension CalenderView: TopViewDelegate {
    
    func didTapBack() {
        viewModel.goBackToPrevMonth()
    }
    
    func didTapNext() {
        viewModel.goToNextMonth()
    }
}

extension CalenderView: MonthGridViewDelegate {
    
    func didSelectDate(at indexPath: IndexPath) {
        viewModel.selectDate(at: indexPath)
    }
}

extension CalenderView: MonthDateManagerDelegate {
    
    func title(_ title: String) {
        topView.setTitle(title)
    }
    
    func selectedDate(_ date: Date) {
        delegate?.didSelectDate(date)
        monthGridView.reloadData()
    }
}

