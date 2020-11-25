//
//  AppDelegate.swift
//  VendingApp
//
//  Created by UN A on 13/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            window!.overrideUserInterfaceStyle = .light
        }
        let navigationController = UINavigationController(
            rootViewController: FirstUIComposer.composedWith(engine: VendingEngine(changeHandler: ChangeCalculator())))
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        return true
    }
}

