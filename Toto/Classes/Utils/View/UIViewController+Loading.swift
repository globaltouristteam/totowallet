//
//  UIViewController+Loading.swift
//  Toto
//
//  Created by Nhuan Vu on 3/16/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    public func showToast(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.mode = .text
        hud.hide(animated: true, afterDelay: 1)
    }
}
