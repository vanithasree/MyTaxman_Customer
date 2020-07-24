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
    
    @IBOutlet weak var firstBtn: DLRadioButton!
    
    @IBOutlet weak var nextBtn: UIButton!
 
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        firstBtn.setOptionChooseTheme(btn: firstBtn, title: "Individual")
        firstBtn.marginWidth = 10.0
        firstBtn.isIconSquare = false
        firstBtn.icon = UIImage(named: "Radio")!
        firstBtn.iconSelected = UIImage(named: "RadioSelected")!
        
       // firstBtn.contentHorizontalAlignment = .left
        
     //   firstBtn.circleColor = ColorManager.textDarkGreenColor.color
        
        //radioButton.indicatorColor = buttonColor;
        
        
        
        // Do any additional setup after loading the view.
    }
    
    /*func setViewUI(){
        
        titleLabel.setTitleForPageScreenTitle(label: titleLabel, titleText: "Do you need this service for a\nbusiness or an individual?")
        individualBtn.setOptionChooseTheme(btn: individualBtn, title: "Individual")
        businessBtn.setOptionChooseTheme(btn: businessBtn, title: "Business")
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Next")
        
    }*/
  
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
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
