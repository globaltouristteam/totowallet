//
//  Utils.swift
//  Toto
//
//  Created by Nhuan Vu on 7/19/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class Utils {
    private static let currency = "USD"
    
    class func currentCurrency() -> String {
        return currency
    }
    
    class func percent(with amount: Float) -> String {
        return String(format: "%0.2f%%", amount)
    }
    
    class func stringWithNumber(_ number: Float) -> String {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: number as NSNumber)!
    }

    class func stringWithCurrencySymbol(_ amount: Float, btc force: Bool = false) -> String {

        if currentCurrency() == "BTC" || force {
            return String(format: "฿%0.8f", amount)
        } else {
            if amount < 1 {
                return String(format: "$%0.7f", amount)
            }
            let formater = NumberFormatter()
            formater.numberStyle = .decimal
            formater.locale = Locale(identifier: "en_US")
            let string = formater.string(from: amount as NSNumber)!
            return String(format: "$%@", string)
        }
    }

    class func stringWithCurrencyCode(_ amount: Float, btc force: Bool = false) -> String {
        if currentCurrency() == "BTC" || force {
            return "\(amount) BTC"
        } else {
            return "\(amount) \(currentCurrency())"
        }
    }

}
