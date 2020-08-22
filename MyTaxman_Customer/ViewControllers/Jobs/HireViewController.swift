//
//  HireViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class HireViewController: UIViewController {
    
    @IBOutlet var hireTableView: UITableView!
    @IBOutlet var submitButton: UIButton!
    
    var selectedAccontIndexPath: IndexPath?
    private var leadViewModel = LeadViewModel()
    
    var vendorList : [Vendor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViews()
      
    }
    
    
    @IBAction func didTapSubmitAction(_ sender: Any) {
        if let selectedIndexPath = selectedAccontIndexPath {
            let params: Parameters = [
                "vendorid" : self.vendorList[selectedIndexPath.row].vendorid ?? "",
                "taskid" :  self.vendorList[selectedIndexPath.row].taskid ?? "",
                "device_currentdatetime" : Date().dateAndTimetoString()]
            LoadingIndicator.shared.show(forView: self.view)
            leadViewModel.hireVendorTechnician(input: params) { (result: ChangePasswordBase?, alert: AlertMessage?) in
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
        hireTableView.delegate = self
        hireTableView.dataSource = self
        hireTableView.register(OptionTableViewCell.nib, forCellReuseIdentifier: OptionTableViewCell.identifier)
        hireTableView.register(JobHeaderView.nib, forHeaderFooterViewReuseIdentifier: JobHeaderView.identifier)
        hireTableView.estimatedRowHeight = UITableView.automaticDimension
        hireTableView.separatorStyle = .none
        hireTableView.tableFooterView = UIView()
        hireTableView.backgroundColor = .clear
        submitButton.setDarkGreenTheme(btn: submitButton, title: "Submit")
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



extension HireViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier) as? OptionTableViewCell else {
            return UITableViewCell()
        }
        if let selectedIndexPath = selectedAccontIndexPath, selectedIndexPath.row == indexPath.row {
            cell.selectOrUnselectImageView.image = UIImage(named: "RadioSelected")
            
        } else {
            cell.selectOrUnselectImageView.image = UIImage(named: "Radio")
        }
        cell.titleTabel.text = self.vendorList[indexPath.row].vendorname
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JobHeaderView.identifier) as? JobHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        headerView.titleLabel.setLabelCustomProperties(titleText: "Hire business\nWho did you hire?", textColor: .black, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20)), numberOfLines: 0, alignment: .natural)
        
        return headerView
    }
}

extension HireViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Utility.dynamicSize(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAccontIndexPath = indexPath
        self.hireTableView.reloadData()
    }
}
