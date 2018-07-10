//
//  ToursViewController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/10/18.
//  Copyright © 2018 Nhuan Vu. All rights reserved.
//

import UIKit

class ToursViewController: UIViewController {

    @IBAction func btnWalletClicked(_ sender: Any) {
        if EtherKeystore.shared.hasWallets {
            
        } else {
            present(TrustWalletApp.shared.coordinator.navigationController, animated: true, completion: nil)
        }
    }
}

