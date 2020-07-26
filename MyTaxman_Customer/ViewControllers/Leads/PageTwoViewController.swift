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
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var fourthBtn: DLRadioButton!
    
    var pageTwoValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.setViewUIProperties()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        
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
        
        self.setRadioButtonPropertiesForPageTwo(radioBtn: firstBtn, titleString: "Sole trade", tag: 1)
        self.setRadioButtonPropertiesForPageTwo(radioBtn: secondBtn, titleString: "Partnership", tag: 2)
        self.setRadioButtonPropertiesForPageTwo(radioBtn: thirdBtn, titleString: "Company", tag: 3)
         self.setRadioButtonPropertiesForPageTwo(radioBtn: fourthBtn, titleString: "Trust", tag: 4)
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"What is your business\nstructure?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageTwoValueChoosen()
    }
    
    func setRadioButtonPropertiesForPageTwo(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    @objc @IBAction private func logSelectedButtonForPageTwo(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.pageTwoValue = radioButton.selected()!.titleLabel!.text ?? ""
            LeadsManager.shared.postJobsParams?.page2 = self.pageTwoValue
            self.checkIsPageTwoValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        
        if let value = LeadsManager.shared.postJobsParams?.page2 {
            print(LeadsManager.shared.postJobsParams)
            print(value)
            self.redirectToPageThreeScreen()
            LeadsManager.shared.postJobsParams?.page3 = ""
        }
        else {
            self.showToast(message: "Please check the values entered")
        }
        
    }
    
    func redirectToPageThreeScreen() {
        let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageThreeVC, animated: true)
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
