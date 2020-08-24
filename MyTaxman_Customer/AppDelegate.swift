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
import CallKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    class var shared : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var push: SINManagedPush?
    var client: SINClient?
    var callProviderDelegate : CallProviderDelegate?
    var sinCallManager : SinCallManager?
    
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
    func initDelegates(){
        if let client = client, sinCallManager == nil{
            sinCallManager = SinCallManager(client: client)
            callProviderDelegate = CallProviderDelegate(callManager: sinCallManager ?? SinCallManager(client: client))
        }else{
            print("We have a problem in app delegate!")
        }
    }
    func initSinchClient(withUserId userId: String) {
        
        if client == nil {
            print("initializing client 2")
            client = Sinch.client(withApplicationKey: "03987b9e-cdb1-4140-bb65-98d50f7c9374",
                                  applicationSecret: "KlD0ud20WEebaDd5rioVTA==",
                                  environmentHost: "clientapi.sinch.com",
                                  userId: userId)
            client?.setSupportCalling(true)
            // client?.setSupportMessaging(false)
            client?.enableManagedPushNotifications()
            client?.delegate = self
            client?.call().delegate = self
            client?.start()
            client?.startListeningOnActiveConnection()
            initDelegates()
            
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
        print("Received a call from: \(call.remoteUserId ?? "")")
        sinCallManager?.currentCall = call
        NotificationCenter.default.post(name: NSNotification.Name.init("inComingCall"), object: call, userInfo: ["callObj":call])
        
    }
    
}
extension AppDelegate : SINCallClientDelegate {
    
    /* func client(_ client: SINCallClient!, localNotificationForIncomingCall call: SINCall!) -> SINLocalNotification! {
     let notification = SINLocalNotification()
     notification.alertBody = "Incoming call from : \(call.remoteUserId!)"
     return notification
     }*/
    
    // this func is called when app is in foreground/or comes to foreground
    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        print("Received a call from: \(call.remoteUserId ?? "")")
        
        sinCallManager?.currentCall = call
        
        NotificationCenter.default.post(name: NSNotification.Name.init("inComingCall"), object: call, userInfo: ["callObj":call])
    }
    
    // this func is called when app is in background
    func client(_ client: SINCallClient!, willReceiveIncomingCall call: SINCall!) {
        print("Received a call from: \(call.remoteUserId ?? "")")
        
        if UIApplication.shared.applicationState != .active {
            callProviderDelegate?.inComingCall(call: call)
            sinCallManager?.isComingFromCX = true
        }
    }
}
extension AppDelegate : SINManagedPushDelegate {
    func managedPush(_ managedPush: SINManagedPush!, didReceiveIncomingPushWithPayload payload: [AnyHashable : Any]!, forType pushType: String!) {
        handleRemoteNotification(userInfo: payload)
    }
    
    func handleRemoteNotification(userInfo: [AnyHashable : Any]) {
        print(userInfo)
        let result = client?.relayRemotePushNotification(userInfo)
        
        guard let resultIsCall = result?.isCall(), let callCancelled = result?.call().isTimedOut else { return }
        
        if let aps = userInfo[AnyHashable("aps")] as? NSDictionary {
            if let alert = aps.value(forKey: "alert") as? NSDictionary{
                if let callState = alert.value(forKey: "loc-key") as? String{
                    if callState.compare(SINCH_CALL_STATES.Cancelled.rawValue) == ComparisonResult.orderedSame{
                        if let call = sinCallManager?.currentCall {
                            sinCallManager?.endingThe(call: call)
                        }
                        if UIApplication.shared.applicationState != UIApplication.State.active{
                            
                            /* DispatchQueue.global(qos: .userInitiated).async
                             {
                             NotificationCenter.default.post(name: NSNotification.Name.init("openCxCallVC"), object: nil, userInfo: ["userId":result?.call().remoteUserId as! String])
                             
                             }*/
                            NotificationCenter.default.post(name: NSNotification.Name.init("openCxCallVC"), object: nil, userInfo: ["userId":result?.call().remoteUserId as! String])
                            
                            
                        }
                    }else{
                        // post a notification to dismiss cxcallcontroller
                    }
                }
            }
        }
    }
}
// MARK:- UNUserNotificationCenterDelegate
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        print("didReceive ======", userInfo)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        print("willPresent ======", userInfo)
        completionHandler([.alert, .sound, .badge])
    }
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        
        UserDefaults.standard.setValue(token, forKey: "kDeviceToken")
        UserDefaults.standard.synchronize()
        self.push?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register the notification APNS Token")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        self.push?.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    
}
