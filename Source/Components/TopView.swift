//
//  TopView.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

protocol TopViewDelegate: AnyObject {
    func didTapNext()
    func didTapBack()
}

final class TopView: BaseView {
    
    weak var delegate: TopViewDelegate?

    private lazy var nextButton: UIButton = {
        let it = UIButton()
        it.setTitle("▶︎", for: .normal)
        it.setTitleColor(.white, for: .normal)
        it.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        return it
    }()
    
    private lazy var backButton: UIButton = {
        let it = UIButton()
        it.setTitle("◀︎", for: .normal)
        it.setTitleColor(.white, for: .normal)
        it.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        return it
    }()
    
    private var titleLabel: UILabel = {
        let it = UILabel()
        it.textAlignment = .center
        it.textColor = .white
        it.font = .boldSystemFont(ofSize: 20)
        return it
    }()

    override func initializeView() {
        backgroundColor = Style.themeColor
        addSubview(nextButton)
        addSubview(titleLabel)
        addSubview(backButton)
    }
    
    override func initializeConstraints() {
        nextButton.chura.layout.right(-10).size(30).centerY(0)
        backButton.chura.layout.left(10).size(30).centerY(0)
        titleLabel.chura.layout
            .left(backButton.rightAnchor).right(nextButton.leftAnchor)
            .top(0).bottom(0)
    }
    
    @objc private func actionNext() {
        delegate?.didTapNext()
    }
    
    @objc private func actionBack() {
        delegate?.didTapBack()
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
