//
//  CategoryHeaderView.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

protocol CategoryHeaderViewDelegate: class {
    func didClickSeeAll(at view: CategoryHeaderView)
}

class CategoryHeaderView: UICollectionReusableView {
    weak var delegate: CategoryHeaderViewDelegate?
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnSeeAll: UIButton!
    
    @IBAction func btnSeeAllClicked(_ sender: Any) {
        delegate?.didClickSeeAll(at: self)
    }
    
    func config(with category: Category) {
        lblTitle.text = category.name
        lblTitle.textAlignment = category.isPopular ? .center : .natural
        btnSeeAll.isHidden = category.isPopular
    }
}
