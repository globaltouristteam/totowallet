//
//  TourDetailsViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TourDetailsViewController: UIViewController {
    var tour: Tour!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let id = tour.id {
            loadData(with: id)
        }
    }
    
    func setupView() {
        hidesBottomBarWhenPushed = true
        title = tour.title
    }
    
    func loadData(with tour: String) {
        displayLoading()
        HttpService.shared.getTourDetails(tour) { [weak self] (tour, error) in
            guard let `self` = self else { return }
            self.hideLoading()
            if let tour = tour {
                self.tour = tour
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
