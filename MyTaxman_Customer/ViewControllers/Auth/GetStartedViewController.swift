//
//  GetStartedViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class GetStartedViewController: BaseViewController {
    //Outlets
    
    @IBOutlet weak var submitANewJobBtn: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginBgView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = true
        isHideNavigationBar = true
    }
    
    func setupViews() {
                
        titleLabel.text = "Welcome to MyTaxman"
        titleLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        
        submitANewJobBtn.setButtonProperties(title: "SUBMIT A NEW JOB", font: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(18.0)), titleColor: ColorManager.darkText.color)
        submitANewJobBtn.backgroundColor = ColorManager.white.color
        
        loginButton.setButtonProperties(title: "LOGIN TO MY ACCOUNT", font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(20.0)), titleColor: ColorManager.darkText.color)
        loginButton.backgroundColor = .clear
        
        
        doOnMain {
            self.submitANewJobBtn.cornerRadius = 5
            self.loginBgView.roundCorners(corners: [.topLeft , .topRight], radius: 20)
            
            let gradientLayer:CAGradientLayer = CAGradientLayer()
            gradientLayer.frame.size = self.loginButton.frame.size
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.colors = [UIColor.white.cgColor,ColorManager.textVeryLiteGreenColor.color.cgColor]
            self.loginButton.layer.insertSublayer(gradientLayer, below: self.loginButton.titleLabel?.layer)
        }
    }
    
    //MARK: - Button Actions
    @IBAction func didTapSubmitANewJobButton(_ sender: UIButton) {
        redirectToLeadCreateScreen()
    }
    
    @IBAction func didTapLoginAction(_ sender: Any) {
        redirectToLoginScreen()
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
    
    func redirectToLoginScreen() {
        let loginVC = LoginViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
