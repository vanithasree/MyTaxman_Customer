//
//  EditJobDescriptionViewController.swift
//  MyTaxman_Customer
//
//  Created by Vanithasree Rajeshkumar on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class EditJobDescriptionViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    private var leadViewModel = LeadViewModel()
    
    var jobType : JobChoosenType = .activeJob
    var activeJobDetailsForEdit : Quotes?
    var closedJobDetailsForEdit : ClosedJobListDesc?
    var completedJobDetailsForEdit : Ilist?
    
    var taskId : String = ""
    var delegate: DescriptionDoneDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setuViewUI() {
        titleLabel.setLabelCustomProperties(titleText: "Edit Job Description", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(25)), numberOfLines: 0, alignment: .left)
       
        nextBtn.setDarkGreenTheme(btn: nextBtn, title: "Update job details")
        self.setData()
    }
    
    func setData() {
        
        switch self.jobType {
        case .activeJob:
            self.descriptionTextView.text = self.activeJobDetailsForEdit?.description ?? ""
            self.taskId = self.activeJobDetailsForEdit?.taskid ?? ""
        case .completedJob:
            self.descriptionTextView.text = self.completedJobDetailsForEdit?.description ?? ""
            self.taskId = self.completedJobDetailsForEdit?.taskid ?? ""
        case .closedJob:
            self.descriptionTextView.text = self.closedJobDetailsForEdit?.description ?? ""
            self.taskId = self.closedJobDetailsForEdit?.taskid ?? ""
            
        }
        
}
    
    @IBAction func onTappedNextBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        if descriptionTextView.text.isEmpty {
            
        }
        else {
            self.updateDescription()
        }
    }
    
    func updateDescription() {
        descriptionTextView.text = "Todayyyy testttttttntnn"
        let params: Parameters = [
            "taskid" :taskId,
            "description" : descriptionTextView.text ?? ""
        ]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.editJobDesc(input: params) { (result: EditDescriptionBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1" {
                    
                    self.delegate?.descriptionForParticualrTask(taskID: self.taskId, descString: self.descriptionTextView.text, jobType: self.jobType)
                    self.presentAlert(withTitle: "", message:"Updated successfully") {
                        doOnMain {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else {
                    
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
