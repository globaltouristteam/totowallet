//
//  TotoTabBarController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class TotoTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        TrustWalletApp.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        if EtherKeystore.shared.hasWallets {
            addWalletTabs()
        } else {
            addEmptyTabs()
        }
    }

    func addWalletTabs() {
        var controllers: [UIViewController] = []
        /*
        if let tours = viewControllers?.first {
            tours.title = localizedString(forKey: "title_tours")
            tours.tabBarItem.title = localizedString(forKey: "title_tours")
            tours.tabBarItem.image = #imageLiteral(resourceName: "tab_tours")
            controllers.append(tours)
        }
        if let tickers = viewControllers?[1] {
 */
        if let tickers = viewControllers?.first {
            tickers.title = localizedString(forKey: "title_marketcap")
            tickers.tabBarItem.title = localizedString(forKey: "title_marketcap")
            tickers.tabBarItem.image = #imageLiteral(resourceName: "settings-currency")
            controllers.append(tickers)
        }
        if let c = TrustWalletApp.shared.coordinator.inCoordinator?.tokensCoordinator?.navigationController {
            controllers.append(c)
        }
        if let c = TrustWalletApp.shared.coordinator.inCoordinator?.transactionCoordinator?.navigationController {
            controllers.append(c)
        }
        if let c = TrustWalletApp.shared.coordinator.inCoordinator?.settingsCoordinator?.navigationController {
            controllers.append(c)
        }
        viewControllers = controllers
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addEmptyTabs() {
        var controllers: [UIViewController] = []
        /*
        if let tours = viewControllers?.first {
            tours.title = localizedString(forKey: "title_tours")
            tours.tabBarItem.title = localizedString(forKey: "title_tours")
            tours.tabBarItem.image = #imageLiteral(resourceName: "tab_tours")
            controllers.append(tours)
        }
 */
        if let tickers = viewControllers?[1] {
            tickers.title = localizedString(forKey: "title_marketcap")
            tickers.tabBarItem.title = localizedString(forKey: "title_marketcap")
            tickers.tabBarItem.image = #imageLiteral(resourceName: "settings-currency")
            controllers.append(tickers)
        }
        
        let viewModel = InCoordinatorViewModel(config: .current)
        let wallet = UIViewController()
        wallet.view.backgroundColor = .white
        wallet.tabBarItem = viewModel.walletBarItem
        controllers.append(wallet)
        
        let trans = UIViewController()
        trans.view.backgroundColor = .white
        trans.tabBarItem = viewModel.transactionsBarItem
        controllers.append(trans)
        
        let settings = UIViewController()
        settings.view.backgroundColor = .white
        settings.tabBarItem = viewModel.settingsBarItem
        controllers.append(settings)
        
        viewControllers = controllers
        selectedIndex = 0
    }
}

extension TotoTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !EtherKeystore.shared.hasWallets {
            if let index = viewControllers?.index(of: viewController), index >= Tabs.wallet(.none).index {
                // show add wallet
                present(TrustWalletApp.shared.coordinator.navigationController, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}

