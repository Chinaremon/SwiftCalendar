//
//  Ex.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
