//
//  PageSixViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class PageSixViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var pageSixValue : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpViewUI() {
        
        self.setRadioButtonPropertiesForPageSix(radioBtn: firstBtn, titleString: "Correspondence", tag: 1)
        self.setRadioButtonPropertiesForPageSix(radioBtn: secondBtn, titleString: "Face toface", tag: 2)
        self.setRadioButtonPropertiesForPageSix(radioBtn: thirdBtn, titleString: "Both", tag: 3)
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"What type of consultation\ndo you prefer?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsPageSixValueChoosen()
        
    }
    
    func checkIsPageSixValueChoosen() {
        
        if self.pageSixValue.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    
    func setRadioButtonPropertiesForPageSix(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.tag = tag
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    @objc @IBAction private func logSelectedButtonForPageSix(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.pageSixValue = radioButton.selected()!.titleLabel!.text ?? ""
            LeadsManager.shared.postJobsParams?.page7 = self.pageSixValue
            self.checkIsPageSixValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        if let value = LeadsManager.shared.postJobsParams?.page7, !value.isEmpty {
            print(value)
            print(LeadsManager.shared.postJobsParams)
            self.redirectToGetLocationVC()
        }
        else {
            
        }
    }
    
    func redirectToGetLocationVC() {
        let locationVC = GetPlacesViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(locationVC, animated: true)
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
