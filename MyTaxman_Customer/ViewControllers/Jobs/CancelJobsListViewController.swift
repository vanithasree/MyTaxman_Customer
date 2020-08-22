//
//  CancelJobsListViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class CancelJobsListViewController: UIViewController {
    @IBOutlet var cancelJobTableView: UITableView!
    
    var taskId: String = ""
    
    private var leadViewModel = LeadViewModel()
    
    let listArray  : [String] = ["I am not ready to hire a business right now", "I am still in the planning/budgeting phase", "I found someone else to do the job", "I am not happy with the quotes I received", "I am changed my mind, not going to do the job at all", "Something else"]
    var selectedAccontIndexPath: IndexPath?
    
    @IBOutlet var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    @IBAction func didTapCancelAction(_ sender: Any) {
        if let selectedIndexPath = selectedAccontIndexPath {
            let params: Parameters = [
                "taskid" : taskId,
                "cancel_description" : self.listArray[selectedIndexPath.row],
                "device_currentdatetime" : Date().dateAndTimetoString()]
            LoadingIndicator.shared.show(forView: self.view)
            leadViewModel.cancelCustomerTask(input: params) { (result: ChangePasswordBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if result.code == "1" {
                        self.presentAlert(withTitle: "", message: result.desc ?? "") {
                            doOnMain {
                                self.navigationController?.popToRootViewController(animated: true)
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
        else {
            self.showToast(message: "Please select any one")
        }
    }
    func setupViews() {
        cancelJobTableView.delegate = self
        cancelJobTableView.dataSource = self
        cancelJobTableView.register(OptionTableViewCell.nib, forCellReuseIdentifier: OptionTableViewCell.identifier)
        cancelJobTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        cancelJobTableView.estimatedRowHeight = UITableView.automaticDimension
        cancelJobTableView.separatorStyle = .none
        cancelJobTableView.tableFooterView = UIView()
        cancelJobTableView.backgroundColor = .clear
        submitButton.setDarkGreenTheme(btn: submitButton, title: "Confirm Cancellation")
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



extension CancelJobsListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier) as? OptionTableViewCell else {
            return UITableViewCell()
        }
        cell.titleTabel.text = self.listArray[indexPath.row]
        
        if let selectedIndexPath = selectedAccontIndexPath, selectedIndexPath.row == indexPath.row {
            cell.selectOrUnselectImageView.image = UIImage(named: "RadioSelected")
            
        } else {
            cell.selectOrUnselectImageView.image = UIImage(named: "Radio")
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        headerView.titleLabel.setLabelCustomProperties(titleText: "Please select a reason below:", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20)), numberOfLines: 0, alignment: .left)
        return headerView
    }
}

extension CancelJobsListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Utility.dynamicSize(50)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAccontIndexPath = indexPath
        self.cancelJobTableView.reloadData()
    }
}
