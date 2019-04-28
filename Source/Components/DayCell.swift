//
//  CallenderCell.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class DayCell: UICollectionViewCell {
    
    private let higlghtColor = Style.themeColor

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
    
    private var model: Model! {
        didSet {
            label.text = model.text
            label.textColor = model.textColor
        }
    }
    
    func configure(model: Model) {
        label.backgroundColor = .white
        self.model = model
    }

    var shouldHigiht = false {
        didSet{
            label.backgroundColor = shouldHigiht ? higlghtColor : .white
            label.textColor = shouldHigiht ? .white : model.textColor
        }
    }
}


extension DayCell {

    struct Model {
        var text: String = ""
        var textColor: UIColor = .black
    }
}

extension DayCell.Model {

    init(date: Date) {
        let weekday = Calendar.current.component(.weekday, from: date)
        if weekday == 1 {
            textColor = Style.sundayColor
        } else if weekday == 7 {
            textColor = Style.satuadayColor
        } else {
            textColor = .gray
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        text = formatter.string(from: date)
    }
}
