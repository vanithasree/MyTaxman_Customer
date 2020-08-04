//
//  BaseViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
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
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
        
        // Do any additional setup after loading the view.
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
