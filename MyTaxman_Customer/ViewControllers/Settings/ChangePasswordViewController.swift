//
//  ChangePasswordViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField
class ChangePasswordViewController: UIViewController {
    @IBOutlet var currentPasswordTextField: TweeAttributedTextField!
    @IBOutlet var newPasswordTextField: TweeAttributedTextField!
    @IBOutlet var retypePasswordTextField: TweeAttributedTextField!
    
    private var authViewModel = AuthViewModel()
    private var settingsViewModel = SettingsViewModel()
    
    var profileDetail : CustomerProfileDesc?
    var delegate : ApiLoadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        currentPasswordTextField.setTextFieldProperties(placeholderString:"Current Password", isSecureText: false)
        newPasswordTextField.setTextFieldProperties(placeholderString:"New Password", isSecureText: false)
        retypePasswordTextField.setTextFieldProperties(placeholderString:"Retype Password", isSecureText: false)
        
        let rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveChanges))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func saveChanges() {
        self.view.endEditing(true)
        let currentPassword:ValidationMessage = authViewModel.validatePassword(currentPasswordTextField.text)
        let newPassword : ValidationMessage = authViewModel.validateNewPassword(newPasswordTextField.text)
        let conformPassword : ValidationMessage = authViewModel.validateConfirmPassword(newPasswordTextField.text, password: retypePasswordTextField.text)
        
        if currentPassword.status && newPassword.status && conformPassword.status  {
            let params: Parameters = [
                "customerid" : UserDetails.shared.userId,
                "oldpassword" : currentPasswordTextField.text ?? "",
                "newpassword" : newPasswordTextField.text ?? "",
                "retypepassword" : retypePasswordTextField.text ?? "",
                "profile_updated_on" : Date().dateAndTimetoString()
            ]
            LoadingIndicator.shared.show(forView: self.view)
            settingsViewModel.changeCusPasswordCredentials(input: params) { (result: ChangePasswordBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if result.code == "1" {
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {
                            doOnMain {
                                self.delegate?.getStatus(value: true)
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
            self.validateTextFieldForChangePassword(textField: currentPasswordTextField)
            self.validateTextFieldForChangePassword(textField: newPasswordTextField)
            self.validateTextFieldForChangePassword(textField: retypePasswordTextField)
        }
    }
    
    
    func validateTextFieldForChangePassword(textField:TweeAttributedTextField) {
        
        if textField == currentPasswordTextField {
            let currentPassword:ValidationMessage = authViewModel.validatePassword(currentPasswordTextField.text)
            if currentPassword.status == false {
                textField.showInfo(currentPassword.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }
        else if textField == newPasswordTextField {
            let passwordValidation:ValidationMessage = authViewModel.validateNewPassword(newPasswordTextField.text)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }
        else  if textField == retypePasswordTextField {
            let passwordValidation:ValidationMessage = authViewModel.validateConfirmPassword(newPasswordTextField.text, password: retypePasswordTextField.text)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
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
