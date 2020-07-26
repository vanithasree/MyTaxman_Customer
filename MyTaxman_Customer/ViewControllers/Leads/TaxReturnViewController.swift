//
//  TaxReturnViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton
import  TweeTextField

class TaxReturnViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var fourthBtn: DLRadioButton!
    @IBOutlet weak var fifthBtn: DLRadioButton!
    
    @IBOutlet weak var otherView: UIView!
    
    @IBOutlet weak var otherTextField: TweeAttributedTextField!
    
    var pageThreeValueForIndividual : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewUIObjects()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewUIObjects() {
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Which type of tax return do\nyou need")
        
        self.setRadioButtonPropertiesForIndividualService(radioBtn: firstBtn, titleString: "Single income with simple deductions", tag: 1)
        self.setRadioButtonPropertiesForIndividualService(radioBtn: secondBtn, titleString: "Multiple incomes with simple deductions", tag: 2)
        self.setRadioButtonPropertiesForIndividualService(radioBtn: thirdBtn, titleString: "Single income with complex deductions (Shares, Captial gains, rental income)", tag: 3)
        self.setRadioButtonPropertiesForIndividualService(radioBtn: fourthBtn, titleString: "Multiple income with complex deductions (Shares, Captial gains, rental income)", tag: 4)
        self.setRadioButtonPropertiesForIndividualService(radioBtn: fifthBtn, titleString: "Other (Please specify)", tag: 5)
        otherTextField.setTextFieldProperties(placeholderString: "Other", isSecureText: false)
        otherTextField.delegate = self
        
    }
    
    func setRadioButtonPropertiesForIndividualService(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = true
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Check")!
        radioBtn.iconSelected = UIImage(named: "Checkbox")!
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
    }
}
extension TaxReturnViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            self.pageThreeValueForIndividual = textField.text ?? ""
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            textField.hideInfo()
        }
    }
}
