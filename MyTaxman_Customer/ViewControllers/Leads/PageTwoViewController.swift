//
//  PageTwoViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField
import DLRadioButton

class PageTwoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var otherTextField: TweeAttributedTextField!
    
    var pageTwoValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setViewUIProperties()
        
    }
    
    func checkIsPageTwoValueChoosen() {
        
        if self.pageTwoValue.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    func setViewUIProperties() {
        
        self.setRadioButtonPropertiesForPageTwo(radioBtn: firstBtn, titleString: "Individual", tag: 1)
        self.setRadioButtonPropertiesForPageTwo(radioBtn: secondBtn, titleString: "Business", tag: 2)
        self.setRadioButtonPropertiesForPageTwo(radioBtn: thirdBtn, titleString: "Others (Please specify)", tag: 3)
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText: "Are you an employee or a contractor?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
    }
    
    func setRadioButtonPropertiesForPageTwo(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = true
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Check")!
        radioBtn.iconSelected = UIImage(named: "Checkbox")!
    }
    
    @objc @IBAction private func logSelectedButtonForPageTwo(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.pageTwoValue = radioButton.selected()?.titleLabel?.text ?? ""
            self.checkIsPageTwoValueChoosen()
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
    
}
