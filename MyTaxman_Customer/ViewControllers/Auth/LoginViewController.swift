//
//  LoginViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import TweeTextField
class LoginViewController: BaseViewController {

    @IBOutlet var userNameTextField: TweeAttributedTextField!
    @IBOutlet var passwordTextField: TweeAttributedTextField!
    @IBOutlet var forgotButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var accountLabel: UILabel!
    
    private var authViewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = true
        isHideNavigationBar = false
    }
    
    func setupViews() {
        self.title = "Login"
        userNameTextField.setTextFieldProperties(placeholderString:"Email/Mobile Number", isSecureText: false)
        passwordTextField.setTextFieldProperties(placeholderString:"Password", isSecureText: true)
    }
    
    //MARK: - Button Actions

    @IBAction func didTapForgotPasswordAction(_ sender: Any) {
        redirectToForgotPasswordScreen()
    }
    
    @IBAction func didTapLoginAction(_ sender: Any) {
        self.view.endEditing(true)
        
        let verifyEmail : ValidationMessage = authViewModel.validateUsernameTextField(textField: userNameTextField)
        let verifyPassword : ValidationMessage = authViewModel.validatePasswordTextField(passwordTextField: passwordTextField)
        if verifyEmail.status && verifyPassword.status {
            let params: Parameters = [
                "cusemail": userNameTextField.text ?? "",
                "cuspassword": passwordTextField.text ?? ""
            ]
            LoadingIndicator.shared.show(forView: self.view)
            authViewModel.requestLogin(input: params) { (result: LoginBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result))
                        self.redirectToDashBoardScreen()
                    } else {
                        print("No response found.")
                        self.presentAlert(withTitle: error, message: result.desc ?? "")
                    }
                } else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
        else {
            self.validateTextField(textField: userNameTextField)
            self.validateTextField(textField: passwordTextField)
        }
    }
    
    @IBAction func didTapRegisterAction(_ sender: Any) {
        redirectToRegisterScreen()
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

extension LoginViewController {
    
    func redirectToForgotPasswordScreen() {
        let forgotVC = ForgotPasswordViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    func redirectToRegisterScreen() {
        let registerVC = RegisterViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func redirectToDashBoardScreen() {
        let dashboardVC = LeadsDashboardViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        let navigationVC = UINavigationController(rootViewController: dashboardVC)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true) {}
    }
}

extension LoginViewController : UITextFieldDelegate {
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
        case userNameTextField:
            let textString = ValidationManager().getMobileNumber(mobileNumber: newText)
            if textString.isNumber {
                //emailOrMobileTextField.rightViewMode = .always
                //return 11 >= newText.count ? true : false
                let length = Int(ValidationManager().getLength(mobileNumber: textField.text!))
                
                if length == 10 {
                    if range.length == 0 {
                        return false
                    }
                }
//                guard let text = textField.text else { return false }
//                let newString = (text as NSString).replacingCharacters(in: range, with: string)
//                textField.text = ValidationManager().format(with: Constant.k_mobileFormat, phone: newString)
                return false
            } else if newText.isEmpty {
                userNameTextField.rightViewMode = .always
            } else {
                userNameTextField.rightViewMode = .never
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
        if textField == userNameTextField {
            let nameValidation:ValidationMessage = authViewModel.validateUsernameTextField(textField: userNameTextField)
            
            if nameValidation.status == false {
                textField.showInfo(nameValidation.errorMessage ?? "")
                
            } else {
                textField.hideInfo()
                
            }
        } else if textField == passwordTextField {
            let passwordValidation:ValidationMessage = authViewModel.validatePasswordTextField(passwordTextField: passwordTextField)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
                
            } else {
                textField.hideInfo()
            }
        }
    }
}
