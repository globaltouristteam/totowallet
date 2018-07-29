//
//  TotoTabBarController.swift
//  Toto
//
//  Created by Nhuan Vu on 7/11/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let nTotoTabBarUpdated = Notification.Name("nTotoTabBarUpdated")
}

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
        
        getConfigForTotoTabBar()
        updateConfig()
        processChangeConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totoTabBar()?.updateTotoTab()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totoTabBar()?.updateTotoTab()
    }
    
    func addWalletTabs() {
        var controllers: [UIViewController] = []
        if let tours = viewControllers?.first {
            tours.tabBarItem = UITabBarItem(
                title: localizedString(forKey: "title_app"),
                image: #imageLiteral(resourceName: "tab_tours"),
                selectedImage: nil
            )
            controllers.append(tours)
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
        if let tours = viewControllers?.first {
            tours.title = localizedString(forKey: "title_app")
            tours.tabBarItem = UITabBarItem(
                title: localizedString(forKey: "title_app"),
                image: #imageLiteral(resourceName: "tab_tours"),
                selectedImage: nil
            )
            controllers.append(tours)
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
    
    // MARK: - Tab settings
    func getConfigForTotoTabBar() {
        let show = (UserDefaults.standard.value(forKey: "totoTabBar") as? Bool) ?? false
        showFirstTab = show
        totoTabBar()?.updateTotoTab()
    }
    
    func totoTabBar() -> TotoTabBar? {
        return tabBar as? TotoTabBar
    }
    
    func updateConfig() {
        HttpService.shared.getProductionBuild { [weak self] (build) in
            guard let `self` = self else { return }
            if let build = build,
                let local = Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
                let localVersion = Int(local) {
                
                let oldConf = showFirstTab
                showFirstTab = localVersion <= build
                self.totoTabBar()?.updateTotoTab()
                UserDefaults.standard.setValue(showFirstTab, forKey: "totoTabBar")
                NotificationCenter.default.post(name: .nTotoTabBarUpdated, object: nil, userInfo: nil)
                
                if !showFirstTab && showFirstTab != oldConf {
                    self.processChangeConfig()
                }
            }
        }
    }
    func processChangeConfig() {
        if !EtherKeystore.shared.hasWallets && showFirstTab == false {
            present(TrustWalletApp.shared.coordinator.navigationController, animated: true, completion: nil)
        }
    }
}

extension TotoTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !EtherKeystore.shared.hasWallets {
            if let index = viewControllers?.index(of: viewController), index > 0 {
                // show add wallet
                present(TrustWalletApp.shared.coordinator.navigationController, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
}
