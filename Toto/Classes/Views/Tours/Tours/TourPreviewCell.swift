//
//  TourPreviewCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TourPreviewCell: UICollectionViewCell {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var imgImage: UIImageView!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDays: UILabel!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var lblPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = 8
        viewContainer.clipsToBounds = true
    }

    func config(with tour: Tour) {
        imgImage.setImage(with: kImageUrl + tour.images!)
        lblTitle.text = tour.title
        
        lblDays.text = Utils.daysNNight(with: tour)
        lblLocation.text = tour.lichtrinh
        lblPrice.attributedText = Utils.priceAttr(with: tour, breakLine: true)
    }
}
