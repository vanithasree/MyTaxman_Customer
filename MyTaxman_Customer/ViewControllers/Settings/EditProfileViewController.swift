//
//  EditProfileViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField

class EditProfileViewController: UIViewController {
    @IBOutlet var nameTextField: TweeAttributedTextField!
    @IBOutlet var emailTextField: TweeAttributedTextField!
    @IBOutlet var mobileTextField: TweeAttributedTextField!
    
    var profileDetail : CustomerProfileDesc?
    private var authViewModel = AuthViewModel()
    private var settingsViewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setValue()
    }
    
    func setupViews() {
        nameTextField.setTextFieldProperties(placeholderString:"Name", isSecureText: false)
        emailTextField.setTextFieldProperties(placeholderString:"Email Address", isSecureText: false)
        mobileTextField.setTextFieldProperties(placeholderString:"Mobile Number", isSecureText: false)
        emailTextField.isUserInteractionEnabled = false
        mobileTextField.isUserInteractionEnabled = false
        
        let rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func saveTapped() {
        
        self.view.endEditing(true)
        
        let verifyName : ValidationMessage = authViewModel.validateNameForSignup(nameTextField.text ?? "")
        let verifyEmail : ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
        let verifyMobile : ValidationMessage = authViewModel.validateMobile(mobileTextField.text)
        if verifyName.status && verifyMobile.status && verifyEmail.status  {
            let params: Parameters = [
                "customerid": UserDetails.shared.userId,
                "customername": nameTextField.text ?? "",
                "profile_updated_on": Date().dateAndTimetoString()
            ]
            LoadingIndicator.shared.show(forView: self.view)
            settingsViewModel.editCustomerProfileDetails(input: params) { (result: EditProfileBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if result.code == "1" {
                        
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {
                            doOnMain {
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        }
                    }
                    else {
                        
                    }
                    
                } else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
            
        }
        else {
            self.validateTextFieldForEditScreen(textField: nameTextField)
        }
        
    }
    
    func validateTextFieldForEditScreen(textField:TweeAttributedTextField) {
        if textField == nameTextField {
            let nameValidation:ValidationMessage = authViewModel.validateNameForSignup(textField.text)
            if nameValidation.status == false {
                textField.showInfo(nameValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }
    }
    
    
    func setValue() {
        nameTextField.text = profileDetail?.customername ?? ""
        emailTextField.text = profileDetail?.email ?? ""
        mobileTextField.text = profileDetail?.mobile ?? ""
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
