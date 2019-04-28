//
//  ViewController.swift
//  Calender
//
//  Created by chutatsu on 2019/04/27.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private var calenderView = CalenderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let v = UIView()
        v.backgroundColor = Style.themeColor
         view.addSubview(calenderView)
        view.addSubview(v)
    
        v.chura.layout
            .left(0).right(0)
            .top(0).bottom(view.safeAreaLayoutGuide.topAnchor)
        
        calenderView.chura.layout
            .left(0).right(0)
            .top(view.safeAreaLayoutGuide.topAnchor).height(Style.maxHeight)
        
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calenderView.selectedDate = Date()
    }
    
}
