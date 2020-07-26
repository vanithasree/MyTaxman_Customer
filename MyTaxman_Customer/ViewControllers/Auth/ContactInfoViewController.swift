//
//  ContactInfoViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField
import Alamofire

enum pageType : Int
{
    case register = 1
    case contact = 2
    case none
}

class ContactInfoViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contactBaseView: UIView!
    @IBOutlet weak var contactTitleLabel: UILabel!
    @IBOutlet var contactSubTitleLabel: UILabel!
    @IBOutlet var contactInfoLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: TweeAttributedTextField!
    @IBOutlet weak var retypePasswordTextField: TweeAttributedTextField!
    @IBOutlet weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    @IBOutlet weak var fullnameTextField: TweeAttributedTextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var bgInfoView: UIView!
    @IBOutlet var contactViewHeightConstaints: NSLayoutConstraint!
    
    @IBOutlet var pwdTextField: TweeAttributedTextField!
    @IBOutlet var bgPasswordView: UIView!
    @IBOutlet var submitPasswordButton: UIButton!
    
    var getPageType : pageType = .none

    private var authViewModel = AuthViewModel()
    var isAllConditionSatisfied:Bool = false {
        didSet {
            doOnMain {
                self.submitBtn.isHidden = !self.isAllConditionSatisfied
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        // Do any additional setup after loading the view.
        setupViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isTransparent = false
        isHideNavigationBar = false
    }
    
    func showRegisterInfoView(isShow: Bool) {
        if !isShow {
            bgInfoView.isHidden = true
            contactInfoLabel.isHidden = true
            self.contactViewHeightConstaints.constant = 220
            self.contactViewHeightConstaints.isActive = true
        }else {
            bgInfoView.isHidden = false
            contactInfoLabel.isHidden = false
            if UIDevice.current.screenType == .iPhones_5_5s_5c_SE  {
                self.contactViewHeightConstaints.constant = self.view.frame.size.height + 50
                self.contactViewHeightConstaints.isActive = true
            }else {
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top ?? 0
                self.contactViewHeightConstaints.constant = self.view.frame.size.height - topPadding
                self.contactViewHeightConstaints.isActive = true
            }
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func showPasswordInfoView(isShow: Bool) {
        if !isShow {
            bgPasswordView.isHidden = true
            self.contactViewHeightConstaints.constant = 220
            self.contactViewHeightConstaints.isActive = true
        }else {
            bgPasswordView.isHidden = false
            self.contactViewHeightConstaints.constant = self.view.frame.size.height
            self.contactViewHeightConstaints.isActive = true
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func setupViewUI() {
        contactTitleLabel.setHeaderTitle(titleText: "Your contact information")
        contactSubTitleLabel.setFooterTitle(titleText: "This is where we will send you quotes")
        contactInfoLabel.setHeaderTitle(titleText: "Hello! Looks like you are new.")
        
        if getPageType == .register {
            bgPasswordView.isHidden = true
            showRegisterInfoView(isShow: false)
        }else if getPageType == .contact {
            bgInfoView.isHidden = true
            contactInfoLabel.isHidden = true
            showPasswordInfoView(isShow: false)
        }
        contactInfoLabel.backgroundColor = ColorManager.backgroundGrey.color
        doOnMain {
            self.contactInfoLabel.cornerRadius = self.contactInfoLabel.frame.size.height / 2
        }
        
        mobileNumberTextField.setTextFieldProperties(placeholderString:"Mobile Number", isSecureText: false)
        mobileNumberTextField.keyboardType = .numberPad
        
        fullnameTextField.setTextFieldProperties(placeholderString:"Full Name", isSecureText: false)
        
        emailTextField.setTextFieldProperties(placeholderString:"Email", isSecureText: false)
        emailTextField.keyboardType = .emailAddress
    
        passwordTextField.setTextFieldProperties(placeholderString:"Password", isSecureText: true)
        retypePasswordTextField.setTextFieldProperties(placeholderString:"Retype Password", isSecureText: true)
        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "Submit")
        submitBtn.applyCornerRadius(amount: 0)

        let eyeShowButton = UIButton(type: .custom)
        eyeShowButton.setImage(UIImage(named: "eyeShow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eyeShowButton.setImage(UIImage(named: "eyeHide")?.withRenderingMode(.alwaysTemplate), for: .selected)
        eyeShowButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        eyeShowButton.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        eyeShowButton.addTarget(self, action: #selector(self.showOrHide), for: .touchUpInside)
        eyeShowButton.tintColor = ColorManager.darkBGTheme.color
        passwordTextField.rightView = eyeShowButton
        passwordTextField.rightViewMode = .always
        
        let eyeConfirmShowButton = UIButton(type: .custom)
        eyeConfirmShowButton.setImage(UIImage(named: "eyeShow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eyeConfirmShowButton.setImage(UIImage(named: "eyeHide")?.withRenderingMode(.alwaysTemplate), for: .selected)
        eyeConfirmShowButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        eyeConfirmShowButton.frame = CGRect(x: CGFloat(retypePasswordTextField.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        eyeConfirmShowButton.addTarget(self, action: #selector(self.confirmShowOrHide), for: .touchUpInside)
        eyeConfirmShowButton.tintColor = ColorManager.darkBGTheme.color
        retypePasswordTextField.rightView = eyeConfirmShowButton
        retypePasswordTextField.rightViewMode = .always
        
        pwdTextField.setTextFieldProperties(placeholderString:"Password", isSecureText: true)
        submitPasswordButton.setDarkGreenTheme(btn: submitPasswordButton, title: "Submit")
        submitPasswordButton.applyCornerRadius(amount: 0)
        
        let contactEyeShowButton = UIButton(type: .custom)
        contactEyeShowButton.setImage(UIImage(named: "eyeShow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        contactEyeShowButton.setImage(UIImage(named: "eyeHide")?.withRenderingMode(.alwaysTemplate), for: .selected)
        contactEyeShowButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        contactEyeShowButton.frame = CGRect(x: CGFloat(pwdTextField.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        contactEyeShowButton.addTarget(self, action: #selector(self.contactShowOrHide), for: .touchUpInside)
        contactEyeShowButton.tintColor = ColorManager.darkBGTheme.color
        pwdTextField.rightView = contactEyeShowButton
        pwdTextField.rightViewMode = .always
    }
    
    @IBAction func contactShowOrHide(_ sender: UIButton) {
          if sender.isSelected == true {
              sender.isSelected = false
          }else {
              sender.isSelected = true
          }
          pwdTextField.isSecureTextEntry.toggle()
      }
      
    
    @IBAction func showOrHide(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func confirmShowOrHide(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
        retypePasswordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapPasswordAction(_ sender: Any) {
    }
    
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        let verifyMobile : ValidationMessage = authViewModel.validateMobile(mobileNumberTextField.text ?? "")
        let verifyPassword : ValidationMessage = authViewModel.validatePasswordTextField(passwordTextField: passwordTextField)
        let verifyConfirmPassword : ValidationMessage = authViewModel.validateConfirmPassword(retypePasswordTextField.text ?? "", password: passwordTextField.text ?? "")
        let verifyName : ValidationMessage = authViewModel.validateNameForSignup(fullnameTextField.text ?? "")
        let verifyEmail : ValidationMessage = authViewModel.validateEmailTextField(textField: emailTextField)
        if verifyName.status && verifyMobile.status && verifyEmail.status && verifyPassword.status && verifyConfirmPassword.status {
            let params: Parameters = [
                "customername": fullnameTextField.text ?? "",
                "email": emailTextField.text ?? "",
                "mobile": mobileNumberTextField.text ?? "",
                "password": passwordTextField.text ?? "",
                "city": "",
                "postalcode": "",
                "deviceid": ""
            ]
            LoadingIndicator.shared.show(forView: self.view)
            authViewModel.requestSignup(input: params) { (result: Register_Base?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "1" {
                        UserDetails.shared.setUserLoginData(data: try! JSONEncoder().encode(result.customerid?.first))
                        self.redirectToOtpScreen()
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
            self.validateTextField(textField: fullnameTextField)
            self.validateTextField(textField: mobileNumberTextField)
            self.validateTextField(textField: emailTextField)
            self.validateTextField(textField: passwordTextField)
            self.validateTextField(textField: retypePasswordTextField)
        }
    }
    
    func postTask() {
        
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
extension ContactInfoViewController {
    
    func redirectToOtpScreen() {
        let otpVC = OtpViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    func redirectToOtpScreen(customerid : String) {
        let otpVC = OtpViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
        otpVC.customerid = customerid
        self.navigationController?.pushViewController(otpVC, animated: true)
    }
    
    @objc func checkMobileExist() {
        let verifyEmail : ValidationMessage = authViewModel.validateMobile(mobileNumberTextField.text ?? "")
        if verifyEmail.status == false {
            self.validateTextField(textField: emailTextField)
        } else {
            let params: Parameters = [
                "cusemailmobile": mobileNumberTextField.text ?? ""
            ]
            LoadingIndicator.shared.show(forView: self.view)
            authViewModel.requestCheckMobile(input: params) { (result: CheckMobile_Base?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if let success = result.code, success == "0" {
                        doOnMain {
                            self.showPasswordInfoView(isShow: false)
                            self.showRegisterInfoView(isShow: true)
                        }
                    } else if let success = result.code, success == "1" {
                        if result.customer?.first?.otp_verified ?? "" == "1"{
                            doOnMain {
                                self.showRegisterInfoView(isShow: false)
                                self.showPasswordInfoView(isShow: true)
                            }
                        }else {
                            self.redirectToOtpScreen(customerid: result.customer?.first?.customerid ?? "")
                        }
                    }else {
                        self.presentAlert(withTitle: error, message: result.desc ?? "")
                    }
                } else if let alert = alert {
                    print(alert.statusCode)
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
            }
        }
    }
}

extension ContactInfoViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? TweeAttributedTextField {
            field.hideInfo()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let existText = textField.text,
            let textRange = Range(range, in: existText) else { return false }
        let newText = existText.replacingCharacters(in: textRange, with: string)
        
        switch textField {
        case emailTextField:
            return 40 >= newText.count ? true : false
        case mobileNumberTextField:
            return 10 >= newText.count ? true : false
        case passwordTextField, retypePasswordTextField:
            return 30 >= newText.count ? true : false
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let field = textField as? TweeAttributedTextField {
            var errorMessage = ""
            switch field  {
            case fullnameTextField:
                errorMessage = authViewModel.validateNameForSignup(field.text).errorMessage ?? ""
            case mobileNumberTextField:
                errorMessage = authViewModel.validateMobile(field.text).errorMessage ?? ""
            case emailTextField:
                errorMessage = authViewModel.validateEmail(field.text).errorMessage ?? ""
            case passwordTextField:
                errorMessage = authViewModel.validatePassword(field.text).errorMessage ?? ""
            case retypePasswordTextField:
                errorMessage = authViewModel.validateConfirmPassword(field.text, password: passwordTextField.text).errorMessage ?? ""
            default:
                break
            }
            if errorMessage == "" {
                if textField == mobileNumberTextField {
                    self.perform(#selector(checkMobileExist), with: nil, with: 0.1)
                }
                field.hideInfo()
                return
            }
            field.showInfo(errorMessage)
        }
    }
    
    func validateTextField(textField:TweeAttributedTextField) {
        if textField == fullnameTextField {
            let passwordValidation:ValidationMessage = authViewModel.validateNameForSignup(textField.text)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }else if textField == mobileNumberTextField {
            let mobileValidation:ValidationMessage = authViewModel.validateMobile(textField.text ?? "")
            if mobileValidation.status == false {
                textField.showInfo(mobileValidation.errorMessage ?? "")
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
        }else if textField == retypePasswordTextField {
            let passwordValidation:ValidationMessage = authViewModel.validateConfirmPassword(textField.text, password: passwordTextField.text)
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }else if textField == emailTextField {
            let passwordValidation:ValidationMessage = authViewModel.validateEmail(textField.text ?? "")
            if passwordValidation.status == false {
                textField.showInfo(passwordValidation.errorMessage ?? "")
            } else {
                textField.hideInfo()
            }
        }
    }
}
