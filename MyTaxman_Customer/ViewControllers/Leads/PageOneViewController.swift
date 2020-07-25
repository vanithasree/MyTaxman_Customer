//
//  PageOneViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import DLRadioButton

class PageOneViewController: UIViewController {
    
    @IBOutlet weak var secondBtn: DLRadioButton!
    @IBOutlet weak var nextBtnBaseView: UIView!
    @IBOutlet weak var firstBtn: DLRadioButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var pageOneValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setViewUI() {
        
        self.setRadioButtonProperties(radioBtn: firstBtn, titleString: "Individual")
        self.setRadioButtonProperties(radioBtn: secondBtn, titleString: "Business")
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText: "Do you need this service for a\nbusiness or an individual?")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        self.checkIsValueChoosen()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setViewUI()
        
    }
    
    func setRadioButtonProperties(radioBtn : DLRadioButton, titleString : String) {
        radioBtn.setOptionChooseTheme(btn: radioBtn, title:titleString)
        radioBtn.marginWidth = 10.0
        radioBtn.isIconSquare = false
        radioBtn.icon = UIImage(named: "Radio")!
        radioBtn.iconSelected = UIImage(named: "RadioSelected")!
    }
    
    func checkIsValueChoosen() {
        if self.pageOneValue.isEmpty {
            nextBtnBaseView.isHidden = true
        }
        else {
            nextBtnBaseView.isHidden = false
        }
    }

    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            self.pageOneValue = radioButton.selected()?.titleLabel?.text ?? ""
            self.checkIsValueChoosen()
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    func redirecToPageTwoVC() {
        let pageTwoVC = PageTwoViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
        self.navigationController?.pushViewController(pageTwoVC, animated: true)
    }
    
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        self.redirecToPageTwoVC()
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
