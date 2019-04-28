//
//  MonthCalenderCell.swift
//  Calender
//
//  Created by chutatsu on 2019/04/28.
//  Copyright © 2019 churabou. All rights reserved.
//

//

import UIKit

protocol MonthGridViewDelegate: AnyObject {
    func didSelectDate(at indexPath: IndexPath)
}

final class MonthGridView: BaseView {

    weak var delegate: MonthGridViewDelegate?

    private let lineSpace: CGFloat = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let it = UICollectionView(frame: .zero, collectionViewLayout: layout)
        it.backgroundColor = .clear
        it.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        it.delegate = self
        it.dataSource = self
        it.isScrollEnabled = false
        return it
    }()
    
    private var dateManager: MonthDateManager!
    
    func configure(manager: MonthDateManager) {
        self.dateManager = manager
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }

    override func initializeView() {
        addSubview(collectionView)
        collectionView.chura.layout.equalToSuperView()
    }
}

extension MonthGridView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateManager.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        if let day = dateManager.days[indexPath.row] {
            cell.configure(model: DayCell.Model(date: day))
        } else {
            cell.configure(model: .init())
        }
        return cell
    }
}

extension MonthGridView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = bounds.width / CGFloat(7)
        return CGSize(width: size, height: Style.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
extension MonthGridView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = dateManager.days[indexPath.row] {
            collectionView
                .visibleCells
                .compactMap {  $0 as? DayCell }
                .forEach { cell in
                    cell.shouldHigiht = false
            }
            collectionView
                .cellForItem(at: indexPath)
                .flatMap { $0 as? DayCell }?
                .shouldHigiht = true
            
            delegate?.didSelectDate(at: indexPath)
        }
    }
}
