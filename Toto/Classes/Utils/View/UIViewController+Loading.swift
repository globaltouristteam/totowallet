//
//  UIViewController+Loading.swift
//  Toto
//
//  Created by Nhuan Vu on 3/16/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    public func showLoading(in seconds: TimeInterval? = nil, fullScreen: Bool = false) {
        if let seconds = seconds {
            HUD.flash(.progress, delay: seconds)
        } else {
            var view = self.view
            if fullScreen && self.navigationController != nil {
                view = self.navigationController?.view
            }
            HUD.show(.progress, onView: view)
        }
    }
    
    public func hideLoading() {
        HUD.hide()
    }
}
