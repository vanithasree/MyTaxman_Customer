//
//  PageThreeViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class PageThreeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var fourthBtn: DLRadioButton!
    
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var fifthBtn: DLRadioButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var pageThreeValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewUI() {
        self.setRadioButtonPropertiesForPageThree(radioBtn: firstBtn, titleString: "Less than $18,200", tag: 1)
        self.setRadioButtonPropertiesForPageThree(radioBtn: secondBtn, titleString: "$18,200 to $37,000", tag: 2)
        self.setRadioButtonPropertiesForPageThree(radioBtn: thirdBtn, titleString: "$37,001 to $87,000", tag: 3)
        self.setRadioButtonPropertiesForPageThree(radioBtn: fourthBtn, titleString: "More than $180,0001", tag: 4)
        self.setRadioButtonPropertiesForPageThree(radioBtn: fifthBtn, titleString: "I'm not sure", tag: 5)
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"What is your annual turnover?")
    
        
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageThreeValueChoosen()
    }
    
    func checkIsPageThreeValueChoosen() {
        
        if self.pageThreeValue.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    func setRadioButtonPropertiesForPageThree(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc @IBAction private func logSelectedButtonForPageThree(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.pageThreeValue = radioButton.selected()!.titleLabel!.text ?? ""
            LeadsManager.shared.postJobsParams?.page4 = self.pageThreeValue
            self.checkIsPageThreeValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        
        if LeadsManager.shared.choosenService == .taxReturns {
            if let value = LeadsManager.shared.postJobsParams?.page4 {
                print(value)
                 print(LeadsManager.shared.postJobsParams)
                self.redirectToPageFourthScreen()
                
            }
            else {
                self.showToast(message: "Please check the values entered")
            }
        }
        
        
        
    }
    
    func redirectToPageFourthScreen() {
        let pageFourVC = PageFourViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageFourVC, animated: true)
    }
}
