//
//  TourDetailsViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TourDetailsViewController: UIViewController {
    var tour: Tour!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let id = tour.id {
            loadData(with: id)
        }
    }
    
    func setupView() {
        hidesBottomBarWhenPushed = true
        setupTour()
   }
    
    func setupTour() {
        //title = tour.title
        collectionView.reloadData()
        pageControl.numberOfPages = tour.imagesList?.count ?? 0
        lblTitle.text = tour.title
        lblDetails.attributedText = detailsText()
        btnBook.setAttributedTitle(Utils.priceAttr(with: tour, breakLine: false), for: .normal)
    }
    
    func detailsText() -> NSAttributedString {
        let attr = NSMutableAttributedString()
        let font = UIFont.systemFont(ofSize: 16)
        let fontBold = UIFont.boldSystemFont(ofSize: 16)
        if let des = tour.desSeo, !des.isEmpty {
            attr.append(NSAttributedString(string: des, attributes: [.font: font]))
            attr.append(NSAttributedString(string: "\n\n"))
        }
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        
        attr.append(NSAttributedString(string: "Departure: ", attributes: [.font: fontBold, .paragraphStyle: style]))
        attr.append(NSAttributedString(string: "", attributes: [.font: font]))
        attr.append(NSAttributedString(string: "\n"))
        
        attr.append(NSAttributedString(string: "Duration: ", attributes: [.font: fontBold, .paragraphStyle: style]))
        attr.append(NSAttributedString(string: Utils.daysNNight(with: tour, icon: false), attributes: [.font: font]))
        attr.append(NSAttributedString(string: "\n"))
        
        attr.append(NSAttributedString(string: "Schedule: ", attributes: [.font: fontBold, .paragraphStyle: style]))
        attr.append(NSAttributedString(string: tour.lichtrinh ?? "", attributes: [.font: font]))
        attr.append(NSAttributedString(string: "\n"))
        
        attr.append(NSAttributedString(string: "Transport: ", attributes: [.font: fontBold, .paragraphStyle: style]))
        attr.append(NSAttributedString(string: tour.vanchuyen ?? "", attributes: [.font: font]))
       return attr
    }
    
    func loadData(with tour: String) {
        displayLoading()
        HttpService.shared.getTourDetails(tour) { [weak self] (tour, error) in
            guard let `self` = self else { return }
            self.hideLoading()
            if let tour = tour {
                self.tour = tour
                self.setupTour()

            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnBookClicked(_ sender: Any) {
        TrustWalletApp.shared.coordinator.inCoordinator?.showTab(.wallet(.none))
    }
}

extension TourDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tour.imagesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if let imageView = cell.viewWithTag(10) as? UIImageView {
            let url = kImageUrl + tour.imagesList![indexPath.row]
            imageView.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let cell = collectionView.visibleCells.first else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        pageControl.currentPage = indexPath.row
    }
}
