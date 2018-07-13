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
        imgImage.setImage(with: "https://globaltourist.io/mvp/data/tour/500/" + tour.images!)
        lblTitle.text = tour.title
        
        lblDays.text = daysNNight(with: tour)
        lblLocation.text = tour.lichtrinh
        lblPrice.attributedText = price(with: tour)
    }
    
    func price(with tour: Tour) -> NSAttributedString {
        let retValue = NSMutableAttributedString()
        let numberFormater = NumberFormatter()
        numberFormater.locale = Locale.current
        numberFormater.numberStyle = .decimal
        numberFormater.usesGroupingSeparator = true
        
        tour.price2 = "120000"
        tour.price = "90000"

        if let price2 = tour.price2, let oldPrice = Int(price2), oldPrice > 0 {
            if let string = numberFormater.string(from: oldPrice as NSNumber) {
                let attr = NSAttributedString(string: string,
                                              attributes: [.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
                                                           .foregroundColor: UIColor.darkGray,
                                                           .font: UIFont.systemFont(ofSize: 18)])
                retValue.append(attr)
            }
        }
        if let price = tour.price, let currentPrice = Int(price) {
            if let string = numberFormater.string(from: currentPrice as NSNumber) {
                if retValue.string.count > 0 {
                    retValue.append(NSAttributedString(string: "\n"))
                }
                
                let color = UIColor(red: 101, green: 61, blue: 253)
                let fontBig = UIFont.systemFont(ofSize: 18)
                let fontSmall = UIFont.systemFont(ofSize: 12)
                let attr = NSAttributedString(string: string,
                                              attributes: [.foregroundColor: color, .font: fontBig])
                retValue.append(attr)
                
                let attr2 = NSAttributedString(string: "TOTO",
                                               attributes: [.foregroundColor: color,
                                                            .font: fontSmall,
                                                            .baselineOffset: fontBig.capHeight - fontSmall.capHeight])
                retValue.append(attr2)
            }
        }
        
        return retValue
    }
    
    func daysNNight(with tour: Tour) -> String {
        guard let songayId = tour.songayId else  { return "🕒" }
        guard let days = Int(songayId) else { return "🕒"}
        return String(format: localizedString(forKey: "format_days_nights"), "\(days)", "\(days - 1)")
    }
}
