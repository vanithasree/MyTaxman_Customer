//
//  SuperFundsServiceViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class SuperFundsServiceViewController: UIViewController {
    
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var firstBtn: DLRadioButton!
   @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    
    var superFundValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()

        // Do any additional setup after loading the view.
    }
    func setupViewUI() {
        
        self.setRadioButtonPropertiesForSuperAudit(radioBtn: firstBtn, titleString: "Setup", tag: 1)
        self.setRadioButtonPropertiesForSuperAudit(radioBtn: secondBtn, titleString: "Compliance", tag: 2)
      
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Which service do you need?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        checkIsSuperFundValueChoosen()
        
    }
    
    func checkIsSuperFundValueChoosen() {
          
          if self.superFundValue.isEmpty {
              self.nextView.isHidden = true
          }
          else {
              self.nextView.isHidden = false
          }
      }
      
    func setRadioButtonPropertiesForSuperAudit(radioBtn : DLRadioButton, titleString : String, tag:Int) {
           radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
           radioBtn.marginWidth = 10.0
           radioBtn.isMultipleSelectionEnabled = false
           radioBtn.isIconSquare = true
           radioBtn.icon = UIImage(named: "Radio")!
           radioBtn.iconSelected = UIImage(named: "RadioSelected")!
       }
       
       @objc @IBAction private func logSelectedButtonForSuperAudit(radioButton : DLRadioButton) {
           if (radioButton.isMultipleSelectionEnabled) {
               for button in radioButton.selectedButtons() {
                   print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
               }
           } else {
               self.superFundValue = radioButton.selected()!.titleLabel!.text ?? ""
               self.checkIsSuperFundValueChoosen()
               print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
           }
       }
    
    func redirectToPageThreeScreenFromSuperAudit() {
          let pageThreeVC = PageThreeViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
          self.navigationController?.pushViewController(pageThreeVC, animated: true)
      }
      

    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        redirectToPageThreeScreenFromSuperAudit()
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
