//
//  PageFiveViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TweeTextField

class PageFiveViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailTextField: TweeAttributedTextField!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var nothingToAddBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setUpViewUI() {
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText:"Any further details")
        detailTextField.setTextFieldProperties(placeholderString: "Details", isSecureText: false)
        detailTextField.delegate = self
        nothingToAddBtn.setFooterTitle(title: "I have nothing to add")
        nothingToAddBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        imageBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        self.redirectToPageSixScreen()
    }
    
    func redirectToPageSixScreen() {
        let pageSixVC = PageSixViewController.instantiateFromAppStoryboard(appStoryboard: .Leads)
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
    
    @IBAction func onTappedNextBt(_ sender: UIButton) {
        print(LeadsManager.shared.postJobsParams)
        redirectToPageSixScreen()
    }
}
extension PageFiveViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            LeadsManager.shared.postJobsParams?.page6 = textField.text
            textField.hideInfo()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TweeAttributedTextField {
            LeadsManager.shared.postJobsParams?.page6 = textField.text
        }
    }
}
