//
//  JobDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 09/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire


enum JobChoosenType : Int {
    case activeJob = 1
    case completedJob = 2
    case closedJob = 3
}
struct DetailsData {
    var title = ""
    var value = ""
    var isStatusImageViewVisible : Bool = false
}

protocol DescriptionDoneDelegate {
    func descriptionForParticualrTask(taskID : String, descString:String, jobType: JobChoosenType)
}

class JobDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    
    var completedJobDetails : Ilist?
    var activeJobDetails : Quotes?
    var closedJobDetails : ClosedJobListDesc?
    var jobType : JobChoosenType = .activeJob
    
    
    var activeDetailsList : [DetailsData] = []
    var completedDetailList : [DetailsData] = []
    var closedDetailList : [DetailsData] = []
    
    var delegate: DescriptionDoneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        self.formDataBasedOnUserSelection()
        
        // Do any additional setup after loading the view.
    }
    
    func formDataBasedOnUserSelection() {
        switch self.jobType {
            
        case .activeJob:
            activeDetailsList = [DetailsData.init(title: "STATUS", value: self.activeJobDetails?.task_submitted_on ?? "", isStatusImageViewVisible: true), DetailsData.init(title: "Location", value: self.activeJobDetails?.service_location ?? "", isStatusImageViewVisible: false), DetailsData.init(title: "Description", value: self.activeJobDetails?.description ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.activeJobDetails?.page1_title ?? "", value: self.activeJobDetails?.page1 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.activeJobDetails?.page2_title ?? "", value: self.activeJobDetails?.page2 ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.activeJobDetails?.page3_title ?? "", value: self.activeJobDetails?.page3 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.activeJobDetails?.page4_title ?? "", value: self.activeJobDetails?.page4 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.activeJobDetails?.page5_title ?? "", value: self.activeJobDetails?.page5 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.activeJobDetails?.page6_title ?? "", value: self.activeJobDetails?.page6 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.activeJobDetails?.page7_title ?? "", value: self.activeJobDetails?.page7 ?? "", isStatusImageViewVisible: false)]
            
            
            self.activeDetailsList = self.activeDetailsList.filter { $0.title != "" }
            
            print(self.activeDetailsList.count)
            
            
            
        case .completedJob:
            completedDetailList = [DetailsData.init(title: "STATUS", value: self.completedJobDetails?.task_submitted_on ?? "", isStatusImageViewVisible: true), DetailsData.init(title: "Location", value: self.completedJobDetails?.service_location ?? "", isStatusImageViewVisible: false), DetailsData.init(title: "Description", value: self.completedJobDetails?.description ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.completedJobDetails?.page1_title ?? "", value: self.completedJobDetails?.page1 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page2_title ?? "", value: self.completedJobDetails?.page2 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page3_title ?? "", value: self.completedJobDetails?.page3 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page4_title ?? "", value: self.completedJobDetails?.page4 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page5_title ?? "", value: self.completedJobDetails?.page5 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page6_title ?? "", value: self.completedJobDetails?.page6 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.completedJobDetails?.page7_title ?? "", value: self.completedJobDetails?.page7 ?? "", isStatusImageViewVisible: false)]
            
            
            self.completedDetailList = self.completedDetailList.filter { $0.title != "" }
            
            
        case .closedJob:
            closedDetailList = [DetailsData.init(title: "STATUS", value: self.closedJobDetails?.task_submitted_on ?? "", isStatusImageViewVisible: true), DetailsData.init(title: "Location", value: self.closedJobDetails?.service_location ?? "", isStatusImageViewVisible: false), DetailsData.init(title: "Description", value: self.closedJobDetails?.description ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.closedJobDetails?.page1_title ?? "", value: self.closedJobDetails?.page1 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.closedJobDetails?.page2_title ?? "", value: self.closedJobDetails?.page2 ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.closedJobDetails?.page3_title ?? "", value: self.closedJobDetails?.page3 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.closedJobDetails?.page4_title ?? "", value: self.closedJobDetails?.page4 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.closedJobDetails?.page5_title ?? "", value: self.closedJobDetails?.page5 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.closedJobDetails?.page6_title ?? "", value: self.closedJobDetails?.page6 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.closedJobDetails?.page7_title ?? "", value: self.closedJobDetails?.page7 ?? "", isStatusImageViewVisible: false)]
            
            
            self.closedDetailList = self.closedDetailList.filter { $0.title != "" }
            
            
        }
        self.detailTableView.reloadData()
    }
    
    func setViewUI() {
        self.title = "Task Details"
        
        detailTableView.register(JobDetailsTableViewCell.nib, forCellReuseIdentifier: JobDetailsTableViewCell.identifier)
        detailTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        detailTableView.tableFooterView = UIView()
        detailTableView.backgroundColor = ColorManager.white.color
        detailTableView.separatorStyle = .none
        detailTableView.estimatedRowHeight = 50
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func redirectViewJobPageForEdit() {
        let descVC = EditJobDescriptionViewController.instantiateFromAppStoryboard(appStoryboard: .Jobs)
        descVC.jobType = self.jobType
        descVC.activeJobDetailsForEdit = self.activeJobDetails
        descVC.delegate = self
        descVC.completedJobDetailsForEdit = self.completedJobDetails
        descVC.closedJobDetailsForEdit = self.closedJobDetails
        self.navigationController?.pushViewController(descVC, animated: true)
    }
    
}
extension JobDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.jobType {
        case .activeJob:
            return self.activeDetailsList.count
        case .completedJob:
            return self.completedDetailList.count
        case .closedJob:
            return self.closedDetailList.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : JobDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobDetailsTableViewCell.identifier) as? JobDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = ColorManager.white.color
        if indexPath.row == 0 {
            cell.statusImageViewWidthConstraint.constant = 15
            cell.titleLabelLeadingConstant.constant = 30
        }
        else {
            cell.statusImageViewWidthConstraint.constant = 0
            cell.titleLabelLeadingConstant.constant = 20
        }
        
        if indexPath.row == 2 {
            cell.editBtn.isHidden = false
        }
        else {
            cell.editBtn.isHidden = true
        }
        
        switch self.jobType {
        case .activeJob:
            cell.titleLabel.text = self.activeDetailsList[indexPath.row].title
            cell.valueLabel.text = self.activeDetailsList[indexPath.row].value
        case .completedJob:
            cell.titleLabel.text = self.completedDetailList[indexPath.row].title
            cell.valueLabel.text = self.completedDetailList[indexPath.row].value
        case .closedJob:
            cell.titleLabel.text = self.closedDetailList[indexPath.row].title
            cell.valueLabel.text = self.closedDetailList[indexPath.row].value
            cell.selectionStyle = .none
        }
        
        cell.editBtnClicked = {[weak self] in
            self?.redirectViewJobPageForEdit()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        headerView.titleLabel.setLabelCustomProperties(titleText: "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(25)), numberOfLines: 0, alignment: .left)
        switch self.jobType {
        case .activeJob:
            headerView.titleLabel.text = self.activeJobDetails?.category ?? ""
        case .completedJob:
            headerView.titleLabel.text = self.completedJobDetails?.category ?? ""
        case .closedJob:
            headerView.titleLabel.text = self.closedJobDetails?.category ?? ""
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension JobDetailsViewController : DescriptionDoneDelegate {
    func descriptionForParticualrTask(taskID: String, descString: String, jobType: JobChoosenType) {
        switch jobType {
        case .activeJob:
            
            let descParam = DetailsData(title: "Description", value: descString, isStatusImageViewVisible: false)
            self.activeDetailsList[2] = descParam
            
        case .completedJob:
            let descParam = DetailsData(title: "Description", value: descString, isStatusImageViewVisible: false)
            self.completedDetailList[2] = descParam
        case .closedJob:
            
            let descParam = DetailsData(title: "Description", value: descString, isStatusImageViewVisible: false)
            self.closedDetailList[2] = descParam
        }
        doOnMain {
            self.detailTableView.reloadData()
        }
        
    }
}
