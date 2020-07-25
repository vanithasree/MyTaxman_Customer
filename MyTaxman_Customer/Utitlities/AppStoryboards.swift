//
//  AppStoryboards.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryBoard : String {
    case Auth
    case Leads
    case Tabbar

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController> (viewControllerClass : T.Type) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
