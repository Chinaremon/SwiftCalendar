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
    private var viewModel: CalendarViewModel!
    private let itemHeight = Style.itemHeight
    
    convenience init(viewModel: CalendarViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }
    
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
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension MonthGridView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.configure(model: viewModel.models[indexPath.row])
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
        delegate?.didSelectDate(at: indexPath)
    }
}

extension MonthGridView {
    
    private func hilightRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView
            .visibleCells
            .compactMap {  $0 as? DayCell }
            .forEach { cell in
                cell.model.shouldHilight = collectionView.indexPath(for: cell)! == indexPath
        }
    }
    
}


