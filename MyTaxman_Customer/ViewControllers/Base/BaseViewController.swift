//
//  BaseViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Sinch
import CallKit

class BaseViewController: UIViewController {
    
    var client : SINClient? {
        return AppDelegate.shared.client
    }
    
    public var audioController : SINAudioController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return (appDelegate.client?.audioController())!
    }
    
    var isTransparent: Bool = false {
        didSet{
            if isTransparent {
                navigationController?.navigationBar.backgroundColor = UIColor.clear
                navigationController?.view.backgroundColor = UIColor.clear
                navigationController?.navigationBar.barTintColor = ColorManager.darkTheme.color
                navigationController?.navigationBar.tintColor = ColorManager.darkText.color
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.isTranslucent = true
                navigationItem.titleView = nil
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                
                //self.navigationController!.navigationBar.topItem!.title = "";
                
            } else {
                self.navigationController?.navigationBar.isTranslucent = !isTransparent
                self.navigationController?.navigationBar.barTintColor = ColorManager.darkText.color
                self.navigationController?.navigationBar.tintColor = ColorManager.darkTheme.color
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorManager.darkText.color]
                
                //self.navigationController!.navigationBar.topItem!.title = "";
            }
        }
    }
    
    var isHideNavigationBar: Bool = false {
        didSet{
            self.navigationController?.navigationBar.isHidden = isHideNavigationBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDetails.shared.isLoggedIn {
            
            NotificationCenter.default.post(name: NSNotification.Name("UserDidLoginNotification"), object: nil, userInfo: ["userId": "suyambu"])
            NotificationCenter.default.addObserver(self, selector: #selector(openVcWhenCallComes(notification:)), name: NSNotification.Name.init("inComingCall"), object: nil)
            //NotificationCenter.default.addObserver(self, selector: #selector(sendCallStatusToSystem(_:)), name: NSNotification.Name.init("openCxCallVC"), object: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func openVcWhenCallComes(notification : Notification){
        print(notification)
        guard
            let call = notification.object as? SINCall else {return}
        
        if (self.client?.isStarted())!{
            AppDelegate.shared.sinCallManager?.currentCall = AppDelegate.shared.sinCallManager?.client.call().callUser(withId: call.remoteUserId)
            let vc = UIStoryboard(name: "Inbox", bundle: nil).instantiateViewController(withIdentifier: "CallViewController") as! CallViewController
            vc.isInComingCall = true
            vc.hidesBottomBarWhenPushed = true
            vc.userId = call.remoteUserId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    func path(forSound soundName: String) -> String? {
        var stringUrl = ""
        if let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav") {
            //print("===: ",audioPath)
            stringUrl = audioPath
        }
        return stringUrl
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
