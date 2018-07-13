//
//  PopularPreviewCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class PopularPreviewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!

    var category: Category = Category()
    
    func config(with category: Category) {
        self.category = category
        collectionView.reloadData()
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
}
