//
//  QuoteDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
struct QuoteDetail {
    let title: String!
}
class QuoteDetailsViewController: UIViewController {
    @IBOutlet var quoteTableView: UITableView!
    var inbox: Inboxlist?
    var quoteDetailList : [QuoteDetail] = [.init(title: "Flat Estimated Cost"),
                                           .init(title: "Site Inspection"),
                                           .init(title: "More Info"),
                                           .init(title: "Additional Info"),
                                           .init(title: "Quote Received On"),
    ]
    
    var jobDetailList : [QuoteDetail] = [.init(title: "Open For Quoting:"),
                                           .init(title: "Location:"),
                                           .init(title: "Description:"),
                                           .init(title: "Tax Return for:"),
                                           .init(title: "Employee Type:"),
                                           .init(title: "Tax Return Type:"),
                                           .init(title: "Tax Bracket:"),
                                           .init(title: "Accounting System:"),
                                           .init(title: "Consultation Preference:")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews(){
        quoteTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        quoteTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        quoteTableView.estimatedRowHeight = UITableView.automaticDimension
        quoteTableView.tableFooterView = UIView()
        quoteTableView.reloadData()
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
        guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.setValue(data: quoteDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
            break
        case 1:
            cell.setJobDetailValue(data: jobDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
        default:
            break
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        headerView.titleLabel.textAlignment = .center
        headerView.titleLabel.text = "Job Details".uppercased()
        return headerView
    }
}

extension QuoteDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return Utility.dynamicSize(80)
    }
}
