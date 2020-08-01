//
//  JobListViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
import BetterSegmentedControl

class JobListViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var segmentView: BetterSegmentedControl!
    
    private var leadViewModel = LeadViewModel()
    
    var activeList : [Quotes] = []
    var completedList : [Ilist] = []
    var closedList : [Quotes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewUI() {
        
        self.nameTitleLabel.setHeaderTitle(titleText: "")
        self.nameTitleLabel.textColor = ColorManager.textLiteGreenColor.color
        self.descriptionLabel.textColor = ColorManager.textLiteGreenColor.color
        self.descriptionLabel.setLabelCustomProperties(titleText: "Let's Get Started", textColor: ColorManager.textLiteGreenColor.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 1, alignment: .left)
        if let name = UserDetails.shared.userLoginData?.customername, !name.isEmpty {
            if name.count >= 10 {
                self.nameTitleLabel.text = "Hello" + " " + name.prefix(10) + "..."
            }
            else {
                self.nameTitleLabel.text = "Hello" + " " + name + "..."
            }
        }
        
        self.setUpSegmentViewControl(segmentControl: segmentView, bgColor: .white, titles: ["Active","Completed", "Closed"])
    }
    
    func setUpSegmentViewControl(segmentControl : BetterSegmentedControl, bgColor:UIColor, titles:[String]) {
        
        let normaFont = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(15.0))
        let selectedFont = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0))
        
        segmentControl.layer.cornerRadius = 10.0
        segmentControl.clipsToBounds = true
        
        segmentControl.segments = LabelSegment.segments(withTitles: titles,
                                                        normalBackgroundColor: .clear,
                                                        normalFont: normaFont,
                                                        normalTextColor: ColorManager.textLiteGreenColor.color,
                                                        selectedBackgroundColor: UIColor(red:0.24, green:0.47, blue:0.68, alpha:1.0),
                                                        selectedFont: selectedFont,
                                                        selectedTextColor: UIColor.white)
        segmentControl.options = [.backgroundColor(UIColor.white.withAlphaComponent(0.4)),
                                  .indicatorViewBackgroundColor(UIColor.clear),
                                  .cornerRadius(10)]

    }

    
    func getCustomerTaskListForActiveView() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        leadViewModel.getCustomerTaskListForActiveTab(input: params) { (result: CustTaskListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1" {
                    self.activeList =  result.desc?.quotes ?? []
                    self.closedList =  self.activeList.filter { $0.task_cancel_status == "1"}
                }
                else {
                    
                }
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
        
    }
    func getCustomerTaskListForCompletedView() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        
        leadViewModel.getCustomerTaskListForCompletedTab(input: params) { (result: CompletedTaskListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1"{
                    self.completedList = result.desc?.ilist ?? []
                }
                
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
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
