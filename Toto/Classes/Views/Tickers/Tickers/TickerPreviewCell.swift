//
//  TickerPreviewCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TickerPreviewCell: UITableViewCell {

    @IBOutlet weak var lblIndex: UILabel!
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbl24h: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblPrice.layer.borderWidth = 0.5
        lblPrice.layer.cornerRadius = 5
    }

    func config(with ticker: Ticker) {
        imgLogo.setImage(with: "https://s2.coinmarketcap.com/static/img/coins/32x32/\(ticker.id ?? 0).png")
        lblIndex.text = "\(ticker.rank ?? 0)"
        
        lblName.text = ticker.name
        
        let quote = ticker.quotes?.with(currency: Utils.currentCurrency())
        let change24h = quote?.percentChange24h ?? 0
        lbl24h.text = Utils.percent(with: change24h)
        lblPrice.text = Utils.stringWithCurrencySymbol(quote?.price ?? 0)
        
        let color = change24h > 0 ? Colors.blue : UIColor.red
        lbl24h.textColor = color
        lblPrice.textColor = color
        lblPrice.layer.borderColor = color.cgColor
    }
}
