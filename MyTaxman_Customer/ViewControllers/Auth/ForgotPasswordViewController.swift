//
//  ForgotPasswordViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField
class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet var emailTextField: TweeAttributedTextField!
    @IBOutlet var resetButton: UIButton!
    private var authViewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = false
        isHideNavigationBar = false
    }
    
    func setupViews() {
        self.title = "Forgot Password"
        emailTextField.setTextFieldProperties(placeholderString:"Email", isSecureText: false)
           resetButton.setDarkGreenTheme(btn: resetButton, title: "RESET PASSWORD")
    }
    
    //MARK: - Button Actions
    @IBAction func didTapResetAction(_ sender: Any) {
        let verifyEmail : ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
        if verifyEmail.status == false {
            self.validateTextField(textField: emailTextField)
        } else {
            LoadingIndicator.shared.show(forView: self.view)
            authViewModel.requestForgotPasswordCode(email: emailTextField.text ?? "") { (result: ForgotPasswordBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        self.presentAlert(withTitle: error, message: result.desc ?? "")
                    }
                } else if let alert = alert {
                    print(alert.statusCode)
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
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

extension ForgotPasswordViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            textField.hideInfo()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let existText = textField.text,
            let textRange = Range(range, in: existText) else { return false }
        
        let newText = existText.replacingCharacters(in: textRange, with: string)
        
        switch textField {
        case emailTextField:
            if newText.isEmpty {
                emailTextField.rightViewMode = .always
            } else {
                emailTextField.rightViewMode = .never
                return 40 >= newText.count ? true : false
            }
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            self.validateTextField(textField: textField)
        }
    }
    
    func validateTextField(textField:TweeAttributedTextField) {
        if textField == emailTextField {
            let nameValidation:ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
            
            if nameValidation.status == false {
                textField.showInfo(nameValidation.errorMessage ?? "")
                
            } else {
                textField.hideInfo()
            }
        }
    }
}
