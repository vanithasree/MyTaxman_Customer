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
import Sinch


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var client: SINClient!
    
    var player: AVAudioPlayer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GoogleApi.shared.initialiseWithKey("AIzaSyBXugsG-nxQoQMEbIUAEaspFtS7-4rnOFk")
        
        //GMSPlacesClient.provideAPIKey("AIzaSyBXugsG-nxQoQMEbIUAEaspFtS7-4rnOFk")
        
        if UserDetails.shared.isLoggedIn {
            redirectToHomePage()
        } else {
            redirectToGetStartPage()
        }
        
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name("UserDidLoginNotification"), object: nil, queue: nil, using: {(_ note: Notification) -> Void in
            print("Got notification")
            let userId = note.userInfo!["userId"] as? String
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.synchronize()
            self.onUserDidLogin(userId!)
        })
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
    
    func onUserDidLogin(_ userId: String)
    {
        // self.push?.registerUserNotificationSettings()
        print("calling initSinch")
        self.initSinchClient(withUserId: userId)
    }
}

extension AppDelegate : SINClientDelegate {
    func initSinchClient(withUserId userId: String) {
        
        if client == nil {
            print("initializing client 2")
            client = Sinch.client(withApplicationKey: "03987b9e-cdb1-4140-bb65-98d50f7c9374",
                                  applicationSecret: "KlD0ud20WEebaDd5rioVTA==",
                                  environmentHost: "clientapi.sinch.com",
                                  userId: userId)
            client.delegate = self
            client.setSupportCalling(true)
            // client.enableManagedPushNotifications()
            client.start()
            client.startListeningOnActiveConnection()
            
        }
    }
    
    //SINCallClient delegates
    func clientDidStart(_ client: SINClient!) {
        print("Sinch client started successfully (version: \(Sinch.version()) with userid \(client.userId)")
    }
    
    func clientDidFail(_ client: SINClient!, error: Error!) {
        print("Sinch client error: \(String(describing: error?.localizedDescription))")
    }
    
    func client(_ client: SINClient, logMessage message: String, area: String, severity: SINLogSeverity, timestamp: Date) {
        print("\(message)")
    }
    
    func callDidProgress(call: SINCall!) {
        
    }
    
    func callDidEstablish(call: SINCall!) {
        //        callStatus.text = "Call Connected"
        print("Call Connected")
    }
    
    func callDidEnd(call: SINCall!) {
        
    }
    func client(client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        //        call.delegate = self;
        //        call.answer()
        
        print("Incoming call coming")
        
    }
}
