//
//  AccountServiceViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton
import TweeTextField

class AccountServiceViewController: UIViewController {
    
    @IBOutlet weak var titleLabek: UILabel!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var fourthBtn: DLRadioButton!
    @IBOutlet weak var fifthBtn: DLRadioButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextview: UIView!
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var otherTextField: TweeAttributedTextField!
    
    var pageOneValueForAccountService : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpViewUI() {
        
        self.setRadioButtonPropertiesForAccountService(radioBtn: firstBtn, titleString: "BookKeeping", tag: 1)
        self.setRadioButtonPropertiesForAccountService(radioBtn: secondBtn, titleString: "Businesss Advisory", tag: 2)
        self.setRadioButtonPropertiesForAccountService(radioBtn: thirdBtn, titleString: "BAS lodgement", tag: 3)
        self.setRadioButtonPropertiesForAccountService(radioBtn: fourthBtn, titleString: "Reconciliations eg.Payroll/payables", tag: 4)
        self.setRadioButtonPropertiesForAccountService(radioBtn: fifthBtn, titleString: "Other (Please specify)", tag: 5)
        otherTextField.setTextFieldProperties(placeholderString: "Other", isSecureText: false)
        otherTextField.delegate = self
        titleLabek.setTitleForPageScreenTitle(label: titleLabek, titleText:"Which service do you need?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkAccountServiceValueisChoosen()
        self.otherView.backgroundColor = .white
        self.otherView.isHidden = true
        
    }
    
    func checkAccountServiceValueisChoosen() {
        if self.pageOneValueForAccountService.isEmpty {
            self.nextview.isHidden = true
        }
        else {
            self.nextview.isHidden = false
        }
        
    }
    
    func setRadioButtonPropertiesForAccountService(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = true
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Check")!
        radioBtn.iconSelected = UIImage(named: "Checkbox")!
    }
    
    @objc @IBAction private func logSelectedButtonForAccountService(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            if radioButton.selectedButtons().count > 0 {
                for button in radioButton.selectedButtons() {
                    print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
                    print(button.tag)
                    
                    let buttonsArray = radioButton.selectedButtons().compactMap { $0.tag == 5}
                    print(buttonsArray)
                    if buttonsArray.contains(true) {
                        self.otherView.isHidden = false
                        self.pageOneValueForAccountService = ""
                        self.checkAccountServiceValueisChoosen()
                    }
                    else {
                        self.otherView.isHidden = true
                        self.pageOneValueForAccountService = button.titleLabel!.text ?? ""
                        self.checkAccountServiceValueisChoosen()
                    }
                }
            }
            else {
                self.pageOneValueForAccountService = ""
                self.otherView.isHidden = true
                self.checkAccountServiceValueisChoosen()
            }
        } else {
            self.pageOneValueForAccountService = radioButton.selected()!.titleLabel!.text ?? ""
            self.checkAccountServiceValueisChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
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
    func redirectToPagethreeScreen() {
        let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageThreeVC, animated: true)
    }
    
    @IBAction func onTapNextBtn(_ sender: UIButton) {
        self.redirectToPagethreeScreen()
    }
    
    
}

extension AccountServiceViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            self.pageOneValueForAccountService = textField.text ?? ""
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            textField.hideInfo()
        }
    }
}
