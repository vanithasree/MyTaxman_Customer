//
//  ChangePasswordViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField
class ChangePasswordViewController: UIViewController {
    @IBOutlet var currentPasswordTextField: TweeAttributedTextField!
    @IBOutlet var newPasswordTextField: TweeAttributedTextField!
    @IBOutlet var retypePasswordTextField: TweeAttributedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        currentPasswordTextField.setTextFieldProperties(placeholderString:"Current Password", isSecureText: false)
        newPasswordTextField.setTextFieldProperties(placeholderString:"New Password", isSecureText: false)
        retypePasswordTextField.setTextFieldProperties(placeholderString:"Retype Password", isSecureText: false)
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
