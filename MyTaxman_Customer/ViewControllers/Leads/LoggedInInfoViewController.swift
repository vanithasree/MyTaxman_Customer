//
//  LoggedInInfoViewController.swift
//  MyTaxman_Customer
//
//  Created by Vanithasree Rajeshkumar on 23/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class LoggedInInfoViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var mailLabek: UILabel!
    private var leadViewModel = LeadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()

        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        headerTitleLabel.setLabelCustomProperties(titleText: "Your contact information", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20)), numberOfLines: 0, alignment: .left)
        
        
        headerLabel.setLabelCustomProperties(titleText: "You are logged in as", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18)), numberOfLines: 0, alignment: .left)
        
      
        
        mailLabek.setLabelCustomProperties(titleText:  UserDetails.shared.userLoginData?.email ?? "", textColor: .darkGray, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18)), numberOfLines: 0, alignment: .left)
        
        captionLabel.setLabelCustomProperties(titleText: "This is where we will send you quotes", textColor: .lightGray, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15)), numberOfLines: 0, alignment: .left)
        
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "Submit")
        
    }
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        self.postTask()
    }
    
    func postTask() {
        
        let input : Parameters = LeadsManager.shared.postJobsParams?.toJSONForNewCustomer ?? [:]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.postTaskLoggedInCustomer(input: input) { (result: PostJobForLoggedInCustomer?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "Success", message:"Task has been successfully posted" ) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
                else {
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "Some error happened")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
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
