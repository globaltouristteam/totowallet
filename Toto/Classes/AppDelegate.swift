//
//  AppDelegate.swift
//  Toto
//
//  Created by Nhuan Vu on 7/10/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LogsMgr().configLogger()
        
        _ = TrustWalletApp.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        TrustWalletApp.shared.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        TrustWalletApp.shared.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        TrustWalletApp.shared.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        TrustWalletApp.shared.applicationDidBecomeActive(application)
   }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
        return TrustWalletApp.shared.application(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        TrustWalletApp.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return TrustWalletApp.shared.application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return TrustWalletApp.shared.application(application, continue:userActivity, restorationHandler: restorationHandler)
    }
}

