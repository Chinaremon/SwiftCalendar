//
//  ViewController.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit


struct Style {
    static var themeColor = UIColor(red: 255/255, green: 132/255, blue: 214/255, alpha: 1)
    static var height: CGFloat = 40
    static let weekViewHeight: CGFloat = 20
    static let topViewHeight: CGFloat = 50
    
    static var maxHeight: CGFloat {
        return height * 6 + weekViewHeight + topViewHeight
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class ViewController: UIViewController {

    private var calenderView = CalenderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        calenderView.frame.origin.y = 100
        calenderView.frame.size.width = view.bounds.width
        calenderView.frame.size.height = Style.maxHeight
        view.addSubview(calenderView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
