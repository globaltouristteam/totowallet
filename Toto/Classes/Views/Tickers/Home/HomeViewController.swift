//
//  HomeViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tickersView: TickersViewController?
    
    @IBOutlet var viewTryAgain: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = localizedString(forKey: "title_app")
        loadData()
    }
    
    @IBAction func btnTryAgainClicked(_ sender: Any) {
        viewTryAgain.isHidden = true
        loadData()
    }
    
    // MARK: - Tours
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination {
        case let tickers as TickersViewController:
            tickersView = tickers

        default:
            break
        }
    }

    // MARK: - Data
    func loadData() {
        displayLoading()
    }
    
    func processLoadDataError(_ error: Error) {
        hideLoading()
        viewTryAgain.isHidden = false
    }
}
