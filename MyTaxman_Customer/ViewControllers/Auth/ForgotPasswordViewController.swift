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
        
        resetButton.backgroundColor = ColorManager.mediumTheme.color
        resetButton.setTitleColor(ColorManager.white.color, for: .normal)
        resetButton.titleLabel?.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(18.0))
        resetButton.cornerRadius = 5
        resetButton.setTitle("RESET PASSWORD", for: .normal)
    }
    
    //MARK: - Button Actions
    @IBAction func didTapResetAction(_ sender: Any) {
        
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
