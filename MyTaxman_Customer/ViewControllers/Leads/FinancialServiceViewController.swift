//
//  FinancialServiceViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton
import TweeTextField

class FinancialServiceViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var otherTextField: TweeAttributedTextField!
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var fifthBtn: DLRadioButton!
    @IBOutlet weak var fourthBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var financialServiceValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpViewUI() {
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"What service do you need?")
        
        self.setRadioButtonPropertiesForFinancialService(radioBtn: firstBtn, titleString: "Portfolio Management", tag: 1)
        self.setRadioButtonPropertiesForFinancialService(radioBtn: secondBtn, titleString: "Developing Financial Goals", tag: 2)
        self.setRadioButtonPropertiesForFinancialService(radioBtn: thirdBtn, titleString: "Superannuation Advice", tag: 3)
        self.setRadioButtonPropertiesForFinancialService(radioBtn: fourthBtn, titleString: "Advice on Assets Purchase", tag: 4)
        self.setRadioButtonPropertiesForFinancialService(radioBtn: fifthBtn, titleString: "Other (Please Specify)", tag: 5)
        
        otherTextField.setTextFieldProperties(placeholderString: "Other", isSecureText: false)
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsFinancialServiceIsChoosen()
        self.otherView.isHidden = true
        
    }
    
    func checkIsFinancialServiceIsChoosen() {
        
        if self.financialServiceValue.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    
    func setRadioButtonPropertiesForFinancialService(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    
    @objc @IBAction private func logSelectedButtonForFinancialService(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            
            if radioButton.selected()?.tag == 5 {
                self.otherView.isHidden = false
                self.financialServiceValue = radioButton.selected()!.titleLabel!.text ?? ""
            }
            else {
                self.otherView.isHidden = true
                self.financialServiceValue = radioButton.selected()!.titleLabel!.text ?? ""
            }
            LeadsManager.shared.postJobsParams?.page1 = self.financialServiceValue
            self.checkIsFinancialServiceIsChoosen()
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
    func redirectToPageThreeScreen() {
        let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageThreeVC, animated: true)
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        if let value = LeadsManager.shared.postJobsParams?.page1, !value.isEmpty {
            self.redirectToPageThreeScreen()
        }
    }
}
