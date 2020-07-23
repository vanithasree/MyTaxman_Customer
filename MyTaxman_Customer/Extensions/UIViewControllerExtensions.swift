//
//  UIViewControllerExtensions.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard : AppStoryBoard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
