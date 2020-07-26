//
//  PageFourViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton
import TweeTextField

class PageFourViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var fourthBtn: DLRadioButton!
    @IBOutlet weak var fifthBtn: DLRadioButton!
    @IBOutlet weak var sixthBtn: DLRadioButton!
    @IBOutlet weak var seventhBtn: DLRadioButton!
    @IBOutlet weak var otheView: UIView!
    
    @IBOutlet weak var otherTextField: TweeAttributedTextField!
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var pageFourValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewUI()
        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        
        self.setRadioButtonPropertiesForPageFour(radioBtn: firstBtn, titleString: "None", tag: 1)
        self.setRadioButtonPropertiesForPageFour(radioBtn: secondBtn, titleString: "MYOB", tag: 2)
        self.setRadioButtonPropertiesForPageFour(radioBtn: thirdBtn, titleString: "Xero", tag: 3)
        self.setRadioButtonPropertiesForPageFour(radioBtn: fourthBtn, titleString: "Saasu", tag: 4)
        self.setRadioButtonPropertiesForPageFour(radioBtn: fifthBtn, titleString: "Quickbooks", tag: 5)
        self.setRadioButtonPropertiesForPageFour(radioBtn: sixthBtn, titleString: "Excel", tag: 6)
        self.setRadioButtonPropertiesForPageFour(radioBtn: seventhBtn, titleString: "Other (Please specify)", tag: 7)
        
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"What accounting systems do you use?")
        otherTextField.setTextFieldProperties(placeholderString:"Other", isSecureText: false)
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageFourValueChoosen()
        showOrHideOthersView(value: true)
        
        
    }
    
    func showOrHideOthersView(value:Bool) {
        self.otheView.isHidden = value
    }
    
    func checkIsPageFourValueChoosen() {
        
        if self.pageFourValue.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    func setRadioButtonPropertiesForPageFour(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    @objc @IBAction private func logSelectedButtonForPageFour(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            if radioButton.tag == 7 {
                self.showOrHideOthersView(value: false)
                self.pageFourValue = ""
                self.checkIsPageFourValueChoosen()
            }
            else {
                self.showOrHideOthersView(value: true)
                self.pageFourValue = radioButton.selected()!.titleLabel!.text ?? ""
                self.checkIsPageFourValueChoosen()
            }
            
            
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        self.redirectToPageFiveScreen()
    }
    
    func redirectToPageFiveScreen() {
        let pageFiveVC = PageFiveViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageFiveVC, animated: true)
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
