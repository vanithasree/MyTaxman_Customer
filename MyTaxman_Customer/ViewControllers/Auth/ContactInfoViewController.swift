//
//  ContactInfoViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 23/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField

class ContactInfoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contactBaseView: UIView!
    @IBOutlet weak var contactTitleLabel: UILabel!
    @IBOutlet var contactSubTitleLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: TweeAttributedTextField!
    @IBOutlet weak var retypePasswordTextField: TweeAttributedTextField!
    @IBOutlet weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    @IBOutlet weak var fullnameTextField: TweeAttributedTextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var isAllConditionSatisfied:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewUI() {
        contactTitleLabel.setHeaderTitle(titleText: "Your contact information")
        contactSubTitleLabel.setFooterTitle(titleText: "This is where we will send you quotes")

        mobileNumberTextField.setTextFieldProperties(placeholderString:"Mobile Number", isSecureText: false)
        mobileNumberTextField.keyboardType = .numberPad
        
//        self.setTextFieldPropertiesOnView(textField: fullnameTextField, placeHolder: "Full Name", isSecureText: false, keypadType: .default)
//        self.setTextFieldPropertiesOnView(textField: emailTextField, placeHolder: "Email", isSecureText: false, keypadType: .emailAddress)
//        self.setTextFieldPropertiesOnView(textField: passwordTextField, placeHolder: "Password", isSecureText: true, keypadType: .default)
//        self.setTextFieldPropertiesOnView(textField: retypePasswordTextField, placeHolder: "Retype Password", isSecureText: true, keypadType: .default)
        
//        submitBtn.setDarkGreenTheme(btn: submitBtn, title: "Submit")
//        submitBtn.isHidden = !isAllConditionSatisfied
    }
    
    
//    func setTextFieldPropertiesOnView(textField:TweeAttributedTextField, placeHolder:String, isSecureText:Bool, keypadType: UIKeyboardType) {
//
//        textField.setTextFieldProperties(placeholderString:placeHolder, isSecureText: isSecureText)
//        textField.borderStyle = .none
//        textField.backgroundColor = .clear
//        textField.keyboardType = keypadType
//        //textField.delegate = self
//        //textField.text = "vanithasree@kuyatechnologies.com"
//    }
    
    @IBAction func onTappedSubmitBtn(_ sender: UIButton) {
        
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
