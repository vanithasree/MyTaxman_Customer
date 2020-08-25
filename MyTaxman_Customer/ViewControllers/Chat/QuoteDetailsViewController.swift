//
//  QuoteDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

struct QuoteDetail {
    let title: String!
}
class QuoteDetailsViewController: UIViewController {
    @IBOutlet var quoteTableView: UITableView!
    var inbox: Inboxlist?
    var jobDetailList : [DetailsData] = []
    private var leadViewModel = LeadViewModel()
    
    var quoteDetailList : [QuoteDetail] = [.init(title: "Flat Estimated Cost"),
                                           .init(title: "Site Inspection"),
                                           .init(title: "More Info"),
                                           .init(title: "Additional Info"),
                                           .init(title: "Quote Received On"),
    ]
    
    /* var jobDetailList : [QuoteDetail] = [.init(title: "Open For Quoting:"),
     .init(title: "Location:"),
     .init(title: "Description:"),
     .init(title: "Tax Return for:"),
     .init(title: "Employee Type:"),
     .init(title: "Tax Return Type:"),
     .init(title: "Tax Bracket:"),
     .init(title: "Accounting System:"),
     .init(title: "Consultation Preference:")]*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        self.getTaskDetailsFromServer()
    }
    
    /* func setData() {
     self.quoteDetailList = [DetailsData.init(title: "STATUS", value: self.inbox?.task_submitted_on ?? "", isStatusImageViewVisible: true), DetailsData.init(title: "Location", value: self.inbox?.service_location ?? "", isStatusImageViewVisible: false), DetailsData.init(title: "Description", value: self.inbox?.description ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.inbox?.page1_title ?? "", value: self.inbox?.page1 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.inbox?.page2_title ?? "", value: self.inbox?.page2 ?? "", isStatusImageViewVisible: false),DetailsData.init(title: self.inbox?.page3_title ?? "", value: self.inbox?.page3 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.inbox?.page4_title ?? "", value: self.inbox?.page4 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.inbox?.page5_title ?? "", value: self.inbox?.page5 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.inbox?.page6_title ?? "", value: self.inbox?.page6 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: self.inbox?.page7_title ?? "", value: self.inbox?.page7 ?? "", isStatusImageViewVisible: false)]
     self.quoteDetailList = self.quoteDetailList.filter { $0.title != "" }
     }*/
    
    
    func setupViews(){
        quoteTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        quoteTableView.register(JobDetailsTableViewCell.nib, forCellReuseIdentifier: JobDetailsTableViewCell.identifier)
        quoteTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        quoteTableView.estimatedRowHeight = UITableView.automaticDimension
        quoteTableView.tableFooterView = UIView()
        quoteTableView.reloadData()
    }
    
    func getTaskDetailsFromServer() {
        let params: Parameters = [
            "taskid" : inbox?.taskid ?? "",
        ]
        LoadingIndicator.shared.show(forView: self.view)
        leadViewModel.getTaskDetailList(input: params) { (result: CustomerJobDetailBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if result.code == "1" {
                    let taskDetail : Quotes? = result.desc?.first
                    
                    if let detail = taskDetail {
                        
                        self.jobDetailList = [DetailsData.init(title: "STATUS", value: detail.task_submitted_on ?? "", isStatusImageViewVisible: true), DetailsData.init(title: "Location", value: detail.service_location ?? "", isStatusImageViewVisible: false), DetailsData.init(title: "Description", value: detail.description ?? "", isStatusImageViewVisible: false),DetailsData.init(title: detail.page1_title ?? "", value: detail.page1 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: detail.page2_title ?? "", value: detail.page2 ?? "", isStatusImageViewVisible: false),DetailsData.init(title: detail.page3_title ?? "", value: detail.page3 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: detail.page4_title ?? "", value: detail.page4 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: detail.page5_title ?? "", value: detail.page5 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: detail.page6_title ?? "", value: detail.page6 ?? "", isStatusImageViewVisible: false), DetailsData.init(title: detail.page7_title ?? "", value: detail.page7 ?? "", isStatusImageViewVisible: false)]
                        
                        self.jobDetailList = self.jobDetailList.filter { $0.title != ""}
                    }
                    else {
                        
                    }
                    doOnMain {
                        self.quoteTableView.reloadData()
                    }
                    
                } else if let alert = alert {
                    self.presentAlert(withTitle: "", message: alert.errorMessage)
                }
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

extension QuoteDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return quoteDetailList.count
        case 1:
            return jobDetailList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
            
            cell.setValue(data: quoteDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 1:
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
            cell.editBtn.isHidden = true
            cell.titleLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
            cell.valueLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
            
            cell.titleLabel.textColor = .black
            cell.valueLabel.textColor = ColorManager.lightGrey.color
            
            cell.titleLabel.text = self.jobDetailList[indexPath.row].title
            cell.valueLabel.text = self.jobDetailList[indexPath.row].value
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
        
        /*
         //guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
         switch indexPath.section {
         case 0:
         cell.setValue(data: quoteDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
         break
         case 1:
         cell.setJobDetailValue(data: self.quoteDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
         default:
         break
         }
         cell.backgroundColor = .clear
         cell.selectionStyle = .none
         return cell*/
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        
        headerView.titleLabel.setLabelCustomProperties(titleText: "Job Details".uppercased(), textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20)), numberOfLines: 0, alignment: .center)
        
        /*  let headerLabel = UILabel(frame: CGRect(x: 10, y: headerView.frame.origin.y + headerView.frame.height  - 50, width:
         tableView.bounds.size.width, height: 30))
         
         headerLabel.setLabelCustomProperties(titleText: inbox?.category ?? "", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(18)), numberOfLines: 0, alignment: .left)
         
         headerView.addSubview(headerLabel) */
        
        return headerView
    }
}

extension QuoteDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return Utility.dynamicSize(80)
    }
}
