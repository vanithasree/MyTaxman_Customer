//
//  TabBarViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = ColorManager.textDarkGreenColor.color
        
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarViewController.self])
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorManager.darkText.color], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorManager.textDarkGreenColor.color], for: .selected)
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
