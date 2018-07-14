//
//  ToursViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/10/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

let kTourLimit = 2

class ToursViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var showAll: Bool = true
    var data: [Category] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Setup
    func setupView() {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
        }
    }
    
    // MARK: - UICollectionViewControllerDelegate, UICollectionViewControllerDatasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = data[section]
        if category.isPopular && !showAll {
            return 1
        }
        if showAll {
            return data[section].tours.count
        } else {
            return min(data[section].tours.count, kTourLimit)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if showAll {
            return CGSize(width: collectionView.frame.width, height: 8)
        } else {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let category = data[indexPath.section]
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: "CategoryHeaderView",
                                                                         for: indexPath) as! CategoryHeaderView
            header.config(with: category)
            header.delegate = self
            if category.isPopular && !showAll {
                header.backgroundColor = .white
            } else {
                header.backgroundColor = .clear
            }
            header.isHidden = showAll
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = (collectionView.frame.width - 32) / (16 / 9)
        height += 70 + 75 + 1
        
        let category = data[indexPath.section]
        if category.isPopular && !showAll {
            height += 16 // Padding
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = data[indexPath.section]
        if category.isPopular && !showAll {
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
        guard let index = collectionView?.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).index(of: view) else { return }
        let category = data[index]
        let controller = storyboard?.instantiateViewController(withIdentifier: "ToursViewController") as! ToursViewController
        controller.title = category.name
        controller.data = [category]
        controller.showAll = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

