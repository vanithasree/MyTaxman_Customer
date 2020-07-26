//
//  LegalAdviceServiceViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class LegalAdviceServiceViewController: UIViewController {
    var legalAdviceValue : String = ""

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var thirdBtn: DLRadioButton!
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()

        // Do any additional setup after loading the view.
    }
    func setupViewUI() {
        self.setRadioButtonPropertiesForLegalAdvice(radioBtn: firstBtn, titleString: "Corporate Law", tag: 1)
        self.setRadioButtonPropertiesForLegalAdvice(radioBtn: secondBtn, titleString: "Tax Law", tag: 2)
        self.setRadioButtonPropertiesForLegalAdvice(radioBtn: thirdBtn, titleString: "Other legal advice", tag: 3)
      
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Which service do you need?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsLegalAdviceValueChoosen()
        
    }
    func checkIsLegalAdviceValueChoosen() {
           
           if self.legalAdviceValue.isEmpty {
               self.nextView.isHidden = true
           }
           else {
               self.nextView.isHidden = false
           }
       }
    func setRadioButtonPropertiesForLegalAdvice(radioBtn : DLRadioButton, titleString : String, tag:Int) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isIconSquare = true
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        redirectToPageSixScreen()
        
    }
    @objc @IBAction private func logSelectedButtonForLegalAdvice(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.legalAdviceValue = radioButton.selected()!.titleLabel!.text ?? ""
            self.checkIsLegalAdviceValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }

    func redirectToPageSixScreen() {
           let pageSixVC = PageFiveViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
           self.navigationController?.pushViewController(pageSixVC, animated: true)
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
