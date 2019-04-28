//
//  a.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit


class BaseView:UIView {
    
    func initializeView(){}
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        initializeConstraints()
    }
    
    func initializeConstraints(){}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

