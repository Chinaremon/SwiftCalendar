//
//  CallenderCell.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class DayCell: UICollectionViewCell {
    
    private let higlghtColor = CalendarStyle.themeColor

    private var label: UILabel = {
        let it = UILabel()
        it.textAlignment = .center
        it.backgroundColor = .white
        it.translatesAutoresizingMaskIntoConstraints = false
        it.clipsToBounds = true
        it.layer.cornerRadius = 30 / 2
        return it
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(label)
        label.chura.layout.size(30).center(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model! {
        didSet {
            label.text = model.text
            label.textColor = model.shouldHilight ? .white : model.textColor
            label.backgroundColor = model.shouldHilight ? higlghtColor : .white
        }
    }
    
    func configure(model: Model) {
        self.model = model
    }
}


extension DayCell {

    struct Model {
        var text: String = ""
        var textColor: UIColor = .black
        var shouldHilight = false
    }
}

extension DayCell.Model {

    init(date: Date) {
        let weekday = Calendar.current.component(.weekday, from: date)
        if weekday == 1 {
            textColor = CalendarStyle.sundayColor
        } else if weekday == 7 {
            textColor = CalendarStyle.satuadayColor
        } else {
            textColor = .gray
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        text = formatter.string(from: date)
    }
}
