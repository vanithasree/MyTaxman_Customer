//
//  EmployeeOrContractViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton
import TweeTextField

class EmployeeOrContractViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    
    var pageTwoValueForIndividual : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Are you an employee or\na contractor?")
        self.setRadioButtonPropertiesForEmpOrContractScreen(radioBtn: firstBtn, titleString: "Employee", tag: 1)
        self.setRadioButtonPropertiesForEmpOrContractScreen(radioBtn: secondBtn, titleString: "Contractor", tag: 2)
        self.setRadioButtonPropertiesForEmpOrContractScreen(radioBtn: thirdBtn, titleString: "Other (Please Specify)", tag: 3)
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageTwoValueForIndividualChoosen()
        
    }
    func checkIsPageTwoValueForIndividualChoosen() {
        
        if self.pageTwoValueForIndividual.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    func setRadioButtonPropertiesForEmpOrContractScreen(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isMultipleSelectionEnabled = true
        radioBtn.tag = tag
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Check")!
        radioBtn.iconSelected = UIImage(named: "Checkbox")!
    }
    
    @objc @IBAction private func logSelectedButtonForEmployeeOrContract(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            if radioButton.selectedButtons().count > 0 {
                for button in radioButton.selectedButtons() {
                    print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
                    print(button.tag)
                    
                    let buttonsArray = radioButton.selectedButtons().compactMap { $0.tag == 3}
                    print(buttonsArray)
                    if buttonsArray.contains(true) {
                        
                        /* self.otherView.isHidden = false*/
                        self.pageTwoValueForIndividual = ""
                        self.checkIsPageTwoValueForIndividualChoosen()
                    }
                    else {
                        /* self.otherView.isHidden = true*/
                        self.pageTwoValueForIndividual = button.titleLabel!.text ?? ""
                        self.checkIsPageTwoValueForIndividualChoosen()
                    }
                }
            }
            else {
                /*  self.pageOneValueForAccountService = ""
                 self.otherView.isHidden = true
                 self.checkAccountServiceValueisChoosen()*/
            }
        } else {
            /*   self.pageOneValueForAccountService = radioButton.selected()!.titleLabel!.text ?? ""
             self.checkAccountServiceValueisChoosen()
             print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!)); */
        }
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
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
