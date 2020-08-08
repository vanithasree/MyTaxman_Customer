//
//  EditProfileViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField

class EditProfileViewController: UIViewController {
    @IBOutlet var nameTextField: TweeAttributedTextField!
    @IBOutlet var emailTextField: TweeAttributedTextField!
    @IBOutlet var mobileTextField: TweeAttributedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        nameTextField.setTextFieldProperties(placeholderString:"Name", isSecureText: false)
        emailTextField.setTextFieldProperties(placeholderString:"Email Address", isSecureText: false)
        mobileTextField.setTextFieldProperties(placeholderString:"Mobile Number", isSecureText: false)
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
