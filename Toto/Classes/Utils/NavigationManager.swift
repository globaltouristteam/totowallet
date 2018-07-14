//
//  NavigationManager.swift
//  Toto
//
//  Created by Nhuan Vu on 7/14/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

class NavigationManager {
    
    static let shared = NavigationManager()
    
    /// Get top view controller in current window
    ///
    /// - Parameter rootViewController: Root view controller
    /// - Returns: Top view controller
    public func topViewController(_ rootViewController: UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!) -> UIViewController {
        if rootViewController.presentedViewController == nil {
            if let navigation = rootViewController as? UINavigationController {
                return navigation.viewControllers.last ?? navigation
            }
            return rootViewController
        }
        
        if let rootViewController = rootViewController.presentedViewController as? UINavigationController {
            let lastViewController = rootViewController.viewControllers.last
            return topViewController(lastViewController!)
        }
        
        if let rootViewController = rootViewController.presentedViewController as? UIAlertController {
            return rootViewController
        }
        
        return topViewController(rootViewController.presentedViewController!)
    }
    
    /// Get top navigation view controller in current window
    ///
    /// - Parameter rootViewController: Root view controller
    /// - Returns: Top navigation view controller
    public func topNavigationController(_ rootViewController: UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!) -> UINavigationController? {
        if let presented = rootViewController.presentedViewController {
            
            if presented is UIAlertController {
                return rootViewController.navigationController!
            }
            
            if let rootViewController = presented as? UINavigationController {
                let lastViewController = rootViewController.viewControllers.last
                return topNavigationController(lastViewController!)
            }
        }
        
        if let vc = rootViewController as? UINavigationController {
            return vc
        }
        
        return rootViewController.navigationController
    }

}
