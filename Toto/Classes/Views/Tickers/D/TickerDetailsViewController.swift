//
//  TickerDetailsViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

struct TickerDetailItem {
    let title: String
    let value: NSAttributedString
}

class TickerDetailsViewController: UITableViewController {
    var ticker: Ticker!
    
    var tickerGraphData: TickerGraphData = TickerGraphData()
    
    var tickerDetails: [TickerDetailItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tickerGraphData.coin = ticker.websiteSlug!
        didSwitchTo(range: .oneD, force: true)
    }
    
    // MARK: - Setup
    func setupView() {
        title = ticker.name
        tableView.tableFooterView = UIView()
        
        let quote = ticker.quotes?.with(currency: Utils.currentCurrency())
        let pricePStr = Utils.percent(with: quote?.percentChange24h ?? 0)
        let priceStr = String(format: "%@ (%@)", Utils.stringWithCurrencySymbol(quote?.price ?? 0), pricePStr)
        let priceAttr = createAttr(string: priceStr, highlight: pricePStr, color: (quote?.percentChange24h ?? 0) >= 0 ? Colors.blue : UIColor.red)
        let item = TickerDetailItem(title: "Price", value: priceAttr)
        tickerDetails.append(item)

        let quoteBTC = ticker.quotes?.with(currency: "BTC")
        let priceBTCPStr = Utils.percent(with: quoteBTC?.percentChange24h ?? 0)
        let priceBTCStr = String(format: "%@ (%@)", Utils.stringWithCurrencySymbol(quoteBTC?.price ?? 0, btc: true), priceBTCPStr)
        let priceBTCAttr = createAttr(string: priceBTCStr, highlight: priceBTCPStr, color: (quoteBTC?.percentChange24h ?? 0) >= 0 ? Colors.blue : UIColor.red)
        let itemBTC = TickerDetailItem(title: "Price BTC", value: priceBTCAttr)
        tickerDetails.append(itemBTC)
        
        let marketAttr = createAttr(string: Utils.stringWithCurrencySymbol(quote?.marketCap ?? 0))
        let itemMarket = TickerDetailItem(title: "Market Cap", value: marketAttr)
        tickerDetails.append(itemMarket)
        
        let volume24hAttr = createAttr(string: Utils.stringWithCurrencySymbol(quote?.volume24h ?? 0))
        let item24h = TickerDetailItem(title: "Volume 24h", value: volume24hAttr)
        tickerDetails.append(item24h)
        
        
        if let supply = ticker.circulatingSupply {
            let attr = createAttr(string: Utils.stringWithNumber(supply))
            let item = TickerDetailItem(title: "Available Supply", value: attr)
            tickerDetails.append(item)
        }
        
        if let supply = ticker.totalSupply {
            let attr = createAttr(string: Utils.stringWithNumber(supply))
            let item = TickerDetailItem(title: "Total Supply", value: attr)
            tickerDetails.append(item)
        }
        
        let c1 = Utils.percent(with: quote?.percentChange1h ?? 0)
        let attrC1 = createAttr(string: c1, highlight: c1, color: (quote?.percentChange1h ?? 0) >= 0 ? Colors.blue : UIColor.red)
        let itemC1 = TickerDetailItem(title: "% Changed 1h", value: attrC1)
        tickerDetails.append(itemC1)
        
        let d1 = Utils.percent(with: quote?.percentChange1h ?? 0)
        let attrD1 = createAttr(string: d1, highlight: d1, color: (quote?.percentChange24h ?? 0) >= 0 ? Colors.blue : UIColor.red)
        let itemD1 = TickerDetailItem(title: "% Changed 1d", value: attrD1)
        tickerDetails.append(itemD1)
        
        let d7 = Utils.percent(with: quote?.percentChange1h ?? 0)
        let attrD7 = createAttr(string: d7, highlight: d7, color: (quote?.percentChange7d ?? 0) >= 0 ? Colors.blue : UIColor.red)
        let itemD7 = TickerDetailItem(title: "% Changed 1w", value: attrD7)
        tickerDetails.append(itemD7)
    }
    
    func createAttr(string: String, highlight: String? = nil, color: UIColor? = nil) -> NSAttributedString {
        let attr = NSMutableAttributedString(string: string, attributes: [.foregroundColor : UIColor.darkGray])
        if let highlight = highlight, let color = color {
            let range = (string as NSString).range(of: highlight)
            attr.addAttributes([.foregroundColor : color], range: range)
        }
        return attr
    }

    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return tickerDetails.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 40
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TickerGraphCell", for: indexPath) as! TickerGraphCell
            cell.delegate = self
            cell.config(with: tickerGraphData.current, data: tickerGraphData.currentCached())
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TickerInfoCell", for: indexPath)
            let item = tickerDetails[indexPath.row]
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.attributedText = item.value
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension TickerDetailsViewController: TickerGraphCellDelegate {
    func didSwitchTo(range: TickerGraphRange) {
        didSwitchTo(range: range, force: false)
    }
    
    func didSwitchTo(range: TickerGraphRange, force: Bool) {
        guard range != tickerGraphData.current || force else { return }
        let oldRange = tickerGraphData.current
        tickerGraphData.current = range
        if tickerGraphData.currentCached().count == 0 {
            tickerGraphData.getData(range: range) { [weak self] (array) in
                guard let `self` = self else { return }
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
        if range != oldRange {
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    func didViewGraphDetai(view: Bool) {
        tableView.isScrollEnabled = !view
    }
}
