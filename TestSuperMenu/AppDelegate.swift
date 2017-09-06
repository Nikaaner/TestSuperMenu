//
//  AppDelegate.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

import AlamofireNetworkActivityIndicator

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private enum Defaults {
        static let yandexMapKitAPIKey = "YWUGe5blayMmRb2unn6S5EAS7PExZbIjam6FLdxeJWPiGkfppYQLN-mEbm-aTONsd4sCrLle60KrUxdD1HPDZURmQzujTFRlH~Es0lPP~X4="
    }
    
    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        YMKConfiguration.sharedInstance().apiKey = Defaults.yandexMapKitAPIKey
        NetworkActivityIndicatorManager.shared.isEnabled = true
        setUpAppearance()
        return true
    }

}

// MARK: - Private

private extension AppDelegate {
    
    func setUpAppearance() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.flamingo
    }
    
}

