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
    private var dateManager: MonthDateManager!
    private let itemHeight = Style.itemHeight
    
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
    
    override func initializeView() {
        addSubview(collectionView)
    }
    
    override func initializeConstraints() {
        collectionView.chura.layout.equalToSuperView()
    }
    
    func configure(manager: MonthDateManager) {
        self.dateManager = manager
    }
    
    func reloadData() {
        collectionView.reloadData()
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
        return CGSize(width: size, height: itemHeight)
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
            hilightRow(at: indexPath.row)
            delegate?.didSelectDate(at: indexPath)
        }
    }
}

extension MonthGridView {
    
    private func hilightRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView
            .visibleCells
            .compactMap {  $0 as? DayCell }
            .forEach { cell in
                cell.shouldHigiht = collectionView.indexPath(for: cell)! == indexPath
        }
    }
    
    func hilightDate(_ date: Date) {
        // HACK: ここら辺改善の余地あり
        dateManager.days.enumerated().forEach { index, day in
            if date.string(format: "yyyymmdd") == day?.string(format: "yyyymmdd") ?? "" {
                hilightRow(at: index)
            }
        }
    }
}


