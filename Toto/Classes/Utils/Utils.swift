//
//  Utils.swift
//  Toto
//
//  Created by Nhuan Vu on 7/19/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

let kImageUrl = "https://globaltourist.io/mvp/data/tour/500/"

class Utils {
    class func priceAttr(with tour: Tour, breakLine: Bool) -> NSAttributedString {
        let retValue = NSMutableAttributedString()
        let numberFormater = NumberFormatter()
        numberFormater.locale = Locale.current
        numberFormater.numberStyle = .decimal
        numberFormater.usesGroupingSeparator = true
        
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
                if breakLine && retValue.string.count > 0 {
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
    
    class func daysNNight(with tour: Tour, icon: Bool = true) -> String {
        let prefix = icon ? "🕒" : ""
        guard let songayId = tour.songayId else  { return prefix }
        guard let days = Int(songayId) else { return prefix}
        if days == 1 {
            return "1 day"
        }
        return prefix + " " + String(format: localizedString(forKey: "format_days_nights"), "\(days)", "\(days - 1)")
    }
}
