//
//  ToursViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/10/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

let kTourLimit = 2

class ToursViewController: UICollectionViewController {
    
    var showAll: Bool = true
    var data: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UICollectionViewControllerDelegate, UICollectionViewControllerDatasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showAll {
            return data[section].tours.count
        } else {
            return min(data[section].tours.count, kTourLimit)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: "CategoryHeaderView",
                                                                         for: indexPath) as! CategoryHeaderView
            header.config(with: data[indexPath.section])
            header.delegate = self
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = data[indexPath.section]
        if category.isPopular() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularPreviewCell", for: indexPath) as! PopularPreviewCell
            cell.config(with: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TourPreviewCell", for: indexPath) as! TourPreviewCell
            cell.config(with: category.tours[indexPath.row])
            return cell
        }
    }
}

extension ToursViewController: CategoryHeaderViewDelegate {
    func didClickSeeAll(at view: CategoryHeaderView) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ToursViewController") as! ToursViewController
        controller.data = data
        controller.showAll = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

