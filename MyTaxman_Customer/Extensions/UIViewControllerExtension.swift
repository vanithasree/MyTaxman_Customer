//
//  UIViewControllerExtension.swift
//  jps
//
//  Created by vijaykarthik on 16/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

enum AlertType : Int
{
    case error = 1
    case success = 2
    case info = 3
}

extension UINavigationController {

    func backToViewController(viewController: Swift.AnyClass) {

            for element in viewControllers as Array {
                if element.isKind(of: viewController) {
                    self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard : AppStoryBoard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    func displayContentController(content: UIViewController) {
        doOnMain {
            self.addChild(content)
            self.view.addSubview(content.view)
            content.didMove(toParent: self)
        }
    }
    
    func hideContentController(content: UIViewController) {
        doOnMain {
            content.willMove(toParent: nil)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                content.view.alpha = 0.0
            }) { (finished) in
                if finished {
                    content.view.removeFromSuperview()
                    content.removeFromParent()
                    content.view.alpha = 1.0
                }
            }
        }
    }
    
    func presentAlert(withTitle title: String, message : String, okayButtonTapped: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
            if okayButtonTapped != nil {
                okayButtonTapped?()
            }
        }
        alertController.addAction(OKAction)
        // change the background color
//        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
//        subview.layer.cornerRadius = 10
//        subview.backgroundColor = ColorManager.white.color
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    func showToastWithMessage(title:String, message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func addChildViewControllerFromCurrentViewController(_ child: UIViewController) {
        child.view.frame = CGRect(x:0,y: 0,width:self.view.bounds.size.width ,height:self.view.bounds.size.height)
        child.willMove(toParent: self)
        self.navigationController?.view.addSubview(child.view)
        self.navigationController?.addChild(child)
        child.didMove(toParent: self)
        
    }
    func removeChildViewController(_ child: UIViewController) {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
