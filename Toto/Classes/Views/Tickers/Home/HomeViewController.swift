//
//  HomeViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import GoogleMobileAds

let ADSBanner = "ca-app-pub-3940256099942544/6300978111"

enum TickerSort: Int {
    case rank = 0
    case name = 1
    case volume24h = 2
    case price = 3
}

class HomeViewController: UIViewController {
    
    var adBannerView: GADBannerView?

    var tickersView: TickersViewController?
    
    var tickers: [Ticker] = []
    
    @IBOutlet var btnSearch: UIBarButtonItem!
    @IBOutlet var btnSorts: [UIButton]!
    @IBOutlet var viewTryAgain: UIView!
    
    var sortBy: TickerSort = .rank
    var sortAcending: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        loadData(refresh: true)
        loadAds()
    }
    
    func setupView() {
        title = localizedString(forKey: "title_app")
        updateSortButton()
    }
    
    @IBAction func btnTryAgainClicked(_ sender: Any) {
        viewTryAgain.isHidden = true
        loadData(refresh: true)
    }
    
    // MARK: - Details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination {
        case let tickers as TickersViewController:
            tickersView = tickers
            tickersView?.delegate = self
            
        case let details as TickerDetailsViewController:
            details.ticker = sender as! Ticker

        default:
            break
        }
    }

    // MARK: - Ticker Data
    func loadData(refresh: Bool) {
        displayLoading()
        let offset = refresh ? 0 : tickers.count + 1
        HttpService.shared.getTickers(offset: offset) { [weak self] (tickers, error) in
            guard let `self` = self else { return }
            self.hideLoading()
            if let tickers = tickers?.data?.tickerData {
                self.tickersView?.loadingMore = false
                self.tickersView?.endOfList = tickers.count < 100
                self.add(tickers: tickers, clear: refresh)
            }
            if error != nil && self.tickers.count == 0 {
                self.viewTryAgain.isHidden = false
            }
        }
    }

    func add(tickers array: [Ticker], clear: Bool) {
        if clear {
            tickers.removeAll()
        }
        tickers.append(contentsOf: array)
        tickersView?.tickers = tickers
        tickersView?.sortData(sortBy: sortBy, sortAcending: sortAcending)
    }
    
    // MARK: Sort
    
    @IBAction func btnSortClicked(_ sender: UIButton) {
        guard let index = btnSorts.index(of: sender) else { return }
        if index == sortBy.rawValue {
            sortAcending = !sortAcending
        } else {
            sortAcending = true
            sortBy = TickerSort(rawValue: index)!
        }
        updateSortButton()
        tickersView?.sortData(sortBy: sortBy, sortAcending: sortAcending)
    }
    
    func updateSortButton() {
        for (index, btn) in btnSorts.enumerated() {
            if index == sortBy.rawValue {
                btn.setImage(self.sortAcending ? #imageLiteral(resourceName: "arrow_up") : #imageLiteral(resourceName: "arrow_down"), for: .normal)
            } else {
                btn.setImage(#imageLiteral(resourceName: "arrow_empty"), for: .normal)
            }
        }
    }
    // MARK: - Search
    
    @IBAction func btnSearchClicked(_ sender: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = nil
        addSearchView()
    }
    
    func addSearchView() {
        let searchBar = UISearchBar()
        searchBar.placeholder = localizedString(forKey: "title_search")
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.enablesReturnKeyAutomatically = false
        navigationItem.titleView = searchBar
        
        tickersView?.endOfList = true
    }
    
    func removeSearchView() {
        navigationItem.titleView?.removeFromSuperview()
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = btnSearch
        tickersView?.endOfList = false
        if tickers.count != tickersView!.tickers.count {
            tickersView?.tickers = tickers
        }
        tickersView?.sortData(sortBy: sortBy, sortAcending: sortAcending)
    }
    
    func filter(key: String) {
        let t = tickers.filter({ $0.name?.contains(key) == true })
        tickersView?.endOfList = true
        tickersView?.tickers = t
        tickersView?.sortData(sortBy: sortBy, sortAcending: sortAcending)
    }
    
    // MARK: - ADS
    func loadAds()  {
        if adBannerView == nil {
            adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
            adBannerView?.adUnitID = ADSBanner
            adBannerView?.delegate = self
            adBannerView?.rootViewController = self.navigationController
        }
        adBannerView?.load(GADRequest())
    }
    

}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSearchView()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textFieldText: NSString = (searchBar.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: text)
        filter(key: txtAfterUpdate)
        return true
    }
}

extension HomeViewController: TickersViewDelegate {
    func didSelectTicker(_ ticker: Ticker) {
        performSegue(withIdentifier: "TickerDetails", sender: ticker)
    }
    
    func didStartLoadMore() {
        loadData(refresh: false)
    }
    
    func didStartRefresh() {
        loadData(refresh: true)
    }
}

// MARK: - ADS
extension HomeViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        LogDebug("GADBannerView Received")
        if let view = navigationController?.view {
            var frame = bannerView.frame
            frame.origin.y = UIScreen.main.bounds.height - bannerView.frame.height - (tabBarController?.tabBar.frame.height ?? 0)
            bannerView.frame = frame
            
            view.addSubview(bannerView)
            
            tickersView?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bannerView.frame.height, right: 0)
            /*
             NSLayoutConstraint.activate([
             bannerView.leftAnchor.constraint(equalTo: view.leftAnchor),
             bannerView.rightAnchor.constraint(equalTo: view.rightAnchor)
             ])
             if #available(iOS 11.0, *) {
             bannerView.bottomAnchor.constraint(equalTo: navigationController!.bottomLayoutGuide.bottomAnchor)
             } else {
             bannerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
             }
             */
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        LogDebug("Fail to receive bannder ad with error: \(error)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.loadAds()
        }
    }
}
