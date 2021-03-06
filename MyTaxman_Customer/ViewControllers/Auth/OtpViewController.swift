//
//  OtpViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SVPinView
import Alamofire
class OtpViewController: BaseViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var pinview: SVPinView!
    @IBOutlet var resendButton: UIButton!
    private var authViewModel = AuthViewModel()
    private var leadViewModel = LeadViewModel()
    var customerid : String = ""
    var getPageType : pageType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = false
        isHideNavigationBar = false
    }
    
    func setupViewUI() {
        titleLabel.setHeaderTitle(titleText: "Your contact information")
        
        resendButton.setButtonProperties(title: "Resend OTP", font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), titleColor: ColorManager.darkTheme.color)
        resendButton.underline(text: "Resend OTP", color: ColorManager.darkTheme.color)
        
        pinViewSetup()
    }
    
    func pinViewSetup() {
        pinview.style = .underline
        pinview.activeBorderLineThickness = 1.5
        pinview.borderLineColor = ColorManager.darkText.color
        pinview.activeBorderLineColor = ColorManager.darkBGTheme.color
        pinview.backgroundColor = ColorManager.white.color
        pinview.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))!
        pinview.pinLength = 4
        pinview.keyboardType = .phonePad
        pinview.shouldSecureText = false
        pinview.interSpace = 10
        pinview.textColor = ColorManager.darkText.color
        pinview.pinInputAccessoryView = UIView()
        pinview.becomeFirstResponderAtIndex = 0
        pinview.didFinishCallback = { [weak self] pin in
            print("The pin entered is \(pin)")
            self?.sendOtpAction(token: pin)
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
    
    func postTask() {
        
        let input : Parameters = LeadsManager.shared.postJobsParams?.toJSONForNewCustomer ?? [:]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.postTaskLoggedInCustomer(input: input) { (result: PostJobForLoggedInCustomer?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.redirectToDashBoardScreen()
                } else {
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "Some error happened")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    func sendOtpAction(token: String) {
        let params: Parameters = [
            "customerid": customerid,
            "otp":token
        ]
        LoadingIndicator.shared.show(forView: self.view)
        authViewModel.requestOtpVerification(input: params) { (result: OtpVerifyBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    //self.presentAlert(withTitle: "", message: result.desc ?? "") {
                    //UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result.customerid?.first))
                    
                    
                    if self.getPageType == .contact {
                        self.postTask()
                    }
                    else {
                        self.redirectToDashBoardScreen()
                    }
                    
                    
                    //}
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: result.desc ?? "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
    
    @IBAction func didTapResendAction(_ sender: Any) {
        let params: Parameters = [
            "customerid": customerid,
        ]
        LoadingIndicator.shared.show(forView: self.view)
        authViewModel.requestResend(input: params) { (result: ResendOtpBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.presentAlert(withTitle: "", message: result.desc ?? "") {}
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: result.desc ?? "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}

extension OtpViewController {
    func redirectToDashBoardScreen() {
        let tabBar = TabBarViewController.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true) {}
    }
}
