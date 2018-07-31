//
//  PopularPreviewCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

protocol PopularPreviewCellDelegate: class {
    func didSelectTour(_ tour: Tour)
}

class PopularPreviewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    weak var delegate: PopularPreviewCellDelegate?
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnNext: UIButton!

    var category: Category = Category()
    
    func config(with category: Category) {
        self.category = category
        collectionView.reloadData()
        pageControl.numberOfPages = category.tours.count
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        guard let cell = collectionView.visibleCells.first else { return }
        guard let indexPath = collectionView.indexPath(for: cell), indexPath.row > 0 else { return }
        let newIndex = IndexPath(row: indexPath.row - 1, section: 0)
        updatePageControlNButtons(at: newIndex)
        collectionView.scrollToItem(at: newIndex, at: .left, animated: true)
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        guard let cell = collectionView.visibleCells.first else { return }
        guard let indexPath = collectionView.indexPath(for: cell), indexPath.row < category.tours.count - 1 else { return }
        let newIndex = IndexPath(row: indexPath.row + 1, section: 0)
        updatePageControlNButtons(at: newIndex)
        collectionView.scrollToItem(at: newIndex, at: .left, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.tours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = (collectionView.frame.width - 32) / (16 / 9)
        height += 70 + 75 + 1
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TourPreviewCell", for: indexPath) as! TourPreviewCell
        cell.config(with: category.tours[indexPath.row])
        cell.viewContainer.layer.borderColor = UIColor.lightGray.cgColor
        cell.viewContainer.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTour(category.tours[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let cell = collectionView.visibleCells.first else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        updatePageControlNButtons(at: indexPath)
    }
    
    func updatePageControlNButtons(at indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        btnBack.isHidden = indexPath.row == 0
        btnNext.isHidden = indexPath.row == category.tours.count - 1
    }
}
