//
//  ToursHomeViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class ToursHomeViewController: UIViewController {
    
    var toursView: ToursViewController?
    
    @IBOutlet var viewTryAgain: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = localizedString(forKey: "title_tours")
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
        case let tours as ToursViewController:
            toursView = tours
            toursView?.view.isHidden = true
            toursView?.showAll = false
        default:
            break
        }
    }

    // MARK: - Data
    func loadData() {
        displayLoading()
        HttpService.shared.getCategories { (categories, error) in
            if let error = error {
                self.processLoadDataError(error)
                return
            }
            HttpService.shared.getTours({ (tours, error) in
                if let error = error {
                    self.processLoadDataError(error)
                    return
                }
                self.processLoadData(categories: categories?.list ?? [], tours: tours?.list ?? [])
            })
        }
    }
    
    func processLoadDataError(_ error: Error) {
        hideLoading()
        viewTryAgain.isHidden = false
    }
    
    func processLoadData(categories: [Category], tours: [Tour]) {
        hideLoading()
        for c in categories {
            c.tours = tours.filter({ !StringUtils.isEmpty(c.catId) && $0.catId?.components(separatedBy: ",").contains(c.catId!) == true })
        }
        var result = categories.filter({ $0.tours.count > 0 })
        let topTours = tours.filter({ $0.noibat == "1" })
        if topTours.count > 0 {
            let cat = Category()
            cat.name = localizedString(forKey: "title_popular_tours")
            cat.isPopular = true
            cat.tours = topTours
            result.insert(cat, at: 0)
        }
        toursView?.data = result
        toursView?.view.isHidden = false
        viewTryAgain.isHidden = true
    }
}
