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
    static var itemHeight: CGFloat = 40
    static let weekViewHeight: CGFloat = 20
    static let topViewHeight: CGFloat = 50
    static var maxHeight: CGFloat {
        return itemHeight * 6 + weekViewHeight + topViewHeight
    }
}
