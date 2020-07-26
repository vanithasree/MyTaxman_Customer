//
//  AuditServiceViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class AuditServiceViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var auditService : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Which service do you need?")
        self.setRadioButtonPropertiesForAudit(radioBtn: firstBtn, titleString: "Not for Profit", tag: 1)
        self.setRadioButtonPropertiesForAudit(radioBtn: secondBtn, titleString: "Corporate", tag: 2)
        self.setRadioButtonPropertiesForAudit(radioBtn: thirdBtn, titleString: "Self Managed Super Fund", tag: 3)
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsAuditServiceValueChoosen()
    }
    func checkIsAuditServiceValueChoosen() {
        
        if self.auditService.isEmpty {
            self.nextView.isHidden = true
        }
        else {
            self.nextView.isHidden = false
        }
    }
    func setRadioButtonPropertiesForAudit(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    @objc @IBAction private func logSelectedButtonForAudit(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.auditService = radioButton.selected()!.titleLabel!.text ?? ""
            LeadsManager.shared.postJobsParams?.page1 = self.auditService
            self.checkIsAuditServiceValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    func redirectToPageThreeScreenFromAudit() {
        let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageThreeVC, animated: true)
    }
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        
        if let value = LeadsManager.shared.postJobsParams?.page1, !value.isEmpty {
            redirectToPageThreeScreenFromAudit()
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
