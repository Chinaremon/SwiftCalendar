//
//  WeekdayView.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class WeekDayView: BaseView {

    private let _backgroundColor = Style.themeColor

    private let weeks = ["Sun","Mon", "Thu", "Wed", "Thu", "Fri", "Sat"]
//     private let weeks = ["日","月", "火", "水", "木", "金", "土"]
    
    private var labels: [UILabel] = []

    override func initializeView() {
        backgroundColor = _backgroundColor
        weeks.forEach { day in
            let it = UILabel()
            it.text = day
            it.textAlignment = .center
            it.font = .systemFont(ofSize: 13)
            it.textColor = .white
            addSubview(it)
            labels.append(it)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.width / CGFloat(weeks.count)
        let height = bounds.height
    
        labels.enumerated().forEach { index, label in
            label.frame.origin = CGPoint(x: width * CGFloat(index), y: 0)
            label.frame.size = CGSize(width: width, height: height)
        }
    }
}
