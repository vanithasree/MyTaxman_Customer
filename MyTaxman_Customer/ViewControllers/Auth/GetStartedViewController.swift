//
//  GetStartedViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    //Outlets
    
    @IBOutlet weak var submitANewJobBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - Button Actions
    
    @IBAction func didTapSubmitANewJobButton(_ sender: UIButton) {
        self.redirectToLeadCreateScreen()
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
extension GetStartedViewController {
    func redirectToLeadCreateScreen() {
        
        let submitANewJobVC = LeadsDashboardViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(submitANewJobVC, animated: true)
        
    }
}
