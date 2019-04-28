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
        
        calenderView.frame.origin.y = 100
        calenderView.frame.size.width = view.bounds.width
        calenderView.frame.size.height = Style.maxHeight
        view.addSubview(calenderView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
         calenderView.hoge()
    }

}
