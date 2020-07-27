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
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageThreeForIndividualValueChoosen()
        
    }
    
    func checkIsPageThreeForIndividualValueChoosen() {
        
        if self.pageThreeValueForIndividual.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
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
    
    
    @IBAction private func logSelectedButtonForTaxReturnIndividual(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            if radioButton.selectedButtons().count > 0 {
                for button in radioButton.selectedButtons() {
                    print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
                    print(button.tag)
                    LeadsManager.shared.postJobsParams?.page3 = button.titleLabel?.text ?? ""
                    
                    let buttonsArray = radioButton.selectedButtons().compactMap { $0.tag == 5}
                    print(buttonsArray)
                    if buttonsArray.contains(true) {
                        self.otherView.isHidden = false
                        self.pageThreeValueForIndividual = ""
                        self.checkIsPageThreeForIndividualValueChoosen()
                    }
                    else {
                        self.otherView.isHidden = true
                        self.pageThreeValueForIndividual = button.titleLabel!.text ?? ""
                        self.checkIsPageThreeForIndividualValueChoosen()
                    }
                }
            }
            else {
                self.pageThreeValueForIndividual = ""
                self.otherView.isHidden = true
                self.checkIsPageThreeForIndividualValueChoosen()
            }
        } else {
            self.pageThreeValueForIndividual = radioButton.selected()!.titleLabel!.text ?? ""
            self.checkIsPageThreeForIndividualValueChoosen()
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
    func redirectToPageThreeScreenFromIndividual() {
        let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageThreeVC, animated: true)
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        if let value = LeadsManager.shared.postJobsParams?.page3 {
            self.redirectToPageThreeScreenFromIndividual()
        }
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
