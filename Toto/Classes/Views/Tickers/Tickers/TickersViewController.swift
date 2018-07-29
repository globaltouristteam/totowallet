//
//  TickersViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/10/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

protocol TickersViewDelegate: class {
    func didSelectTicker(_ ticker: Ticker)

    func didStartLoadMore()

    func didStartRefresh()
}

class TickersViewController: UITableViewController {
    weak var delegate: TickersViewDelegate?
    var tickers: [Ticker] = []
    
    var loadingMore: Bool = false
    var endOfList: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.tableView.tableFooterView = UIView()
    }
    
    func addPTR() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func remnovePTR() {
        refreshControl?.removeFromSuperview()
        refreshControl = nil
    }
    
    func sortData(sortBy: TickerSort, sortAcending: Bool) {
        tickers.sort { (t1, t2) -> Bool in
            switch sortBy {
            case .rank:
                if let r1 = t1.rank, let r2 = t2.rank {
                    return sortAcending ? r1 < r2 :  r1 > r2
                }
            case .name:
                if let r1 = t1.name, let r2 = t2.name {
                    return sortAcending ? r1 < r2 :  r1 > r2
                }
                
            case .volume24h:
                if let r1 = t1.quotes?.with(currency: Utils.currentCurrency()).volume24h, let r2 = t2.quotes?.with(currency: Utils.currentCurrency()).volume24h {
                    return sortAcending ? r1 < r2 :  r1 > r2
                }
            case .price:
                if let r1 = t1.quotes?.with(currency: Utils.currentCurrency()).price, let r2 = t2.quotes?.with(currency: Utils.currentCurrency()).price {
                    return sortAcending ? r1 < r2 :  r1 > r2
                }
            }
            return false
        }
        tableView.reloadData()
    }
    
    @objc func refreshData() {
        refreshControl?.endRefreshing()
        delegate?.didStartRefresh()
    }

    
    // MARK: - Tableview View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TickerPreviewCell", for: indexPath) as! TickerPreviewCell
        cell.config(with: tickers[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectTicker(tickers[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {        
        cell.contentView.backgroundColor = UIColor.darkGray
        if loadingMore || endOfList {
            return
        }
        if indexPath.row + 1 == tickers.count {
            loadingMore = true
            delegate?.didStartLoadMore()
        }
    }
}
