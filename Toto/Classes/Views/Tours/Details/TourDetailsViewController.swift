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
    }
    
    func setupView() {
        hidesBottomBarWhenPushed = true
        title = tour.title
    }
}
