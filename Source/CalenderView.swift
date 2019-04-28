//
//  CalenderView.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class CalenderView: BaseView {
    
    private let topView = TopView()
    private let weekView = WeekDayView()
    private var collectionView = MonthGridView()
    private let dateManager = MonthDateManager()
    
    override func initializeView() {
        topView.delegate = self
        addSubview(topView)
        addSubview(weekView)
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.configure(manager: dateManager)

        [UISwipeGestureRecognizer.Direction.right, .left].forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipe))
            swipe.direction = $0
            collectionView.addGestureRecognizer(swipe)
        }
    }
    
    override func initializeConstraints() {
        topView.chura.layout.top(0).left(0).right(0).height(Style.topViewHeight)
        weekView.chura.layout
            .left(0).top(topView.bottomAnchor).height(Style.weekViewHeight).right(0)
        collectionView.chura.layout
            .top(weekView.bottomAnchor).left(0)
            .right(0).bottom(0)
    }
    
    @objc private func actionSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            didTapNext()
        } else if sender.direction == .right {
            didTapBack()
        }
    }
}

extension CalenderView: TopViewDelegate {
    
    func didTapBack() {
        dateManager.prevMonth()
        collectionView.reloadData()
        topView.setTitle(dateManager.yyyymmString)
    }
    
    func didTapNext() {
        dateManager.nextMonth()
        collectionView.reloadData()
        topView.setTitle(dateManager.yyyymmString)
    }
}

extension CalenderView: MonthGridViewDelegate {
    
    func didSelectDate(at indexPath: IndexPath) {
        if let date = dateManager.days[indexPath.row] {
            topView.setTitle(date.string(format: "yyyy/MM/dd"))
        }
    }
}

