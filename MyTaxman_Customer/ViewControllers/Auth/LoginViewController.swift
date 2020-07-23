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
                    if let success = result.isSuccessful, success {
                        UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result))
                    } else {
                        print("No response found.")
                        self.presentAlert(withTitle: "", message: "")
                    }
                    
                } else if let alert = alert {
                    print(alert.statusCode)
                    print(alert.errorMessage)
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
        else {
//            self.validateTextField(textField: emailOrMobileTextField)
//            self.validateTextField(textField: passwordTextField)
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
        let submitANewJobVC = LeadsDashboardViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(submitANewJobVC, animated: true)
    }
    
    func redirectToRegisterScreen() {
        let registerVC = RegisterViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
