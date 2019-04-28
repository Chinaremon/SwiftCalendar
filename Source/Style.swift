//
//  Style.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//


import UIKit.UIColor

struct Style {
    static var themeColor = UIColor(red: 255/255, green: 132/255, blue: 214/255, alpha: 1)
    static let satuadayColor = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    static let sundayColor = UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)

    static var itemHeight: CGFloat = 40
    static let weekViewHeight: CGFloat = 20
    static let topViewHeight: CGFloat = 50
    static var maxHeight: CGFloat {
        return itemHeight * 6 + weekViewHeight + topViewHeight
    }
}
