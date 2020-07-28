//
//  AppDelegate.swift
//  MyTaxman_Customer
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GMSPlacesClient.provideAPIKey("AIzaSyBXugsG-nxQoQMEbIUAEaspFtS7-4rnOFk")
        
        if UserDetails.shared.isLoggedIn {
            redirectToHomePage()
        } else {
            redirectToGetStartPage()
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func redirectToHomePage() {
        let storyboard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        if let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController {
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        }
    }
    
    func redirectToGetStartPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
        let initialVC = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = initialVC
    }
}

