//
//  BusinessProfileViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
class BusinessProfileViewController: UIViewController {
    @IBOutlet var profileTableView: UITableView!
    var inbox: Inboxlist?
    private var inboxViewModel = InboxViewModel()
    var vendorProfile : VendorProfile_Base?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        requestVenProfile()
    }
    
    func setupViews(){
        profileTableView.register(BusinessProfileTableViewCell.nib, forCellReuseIdentifier: BusinessProfileTableViewCell.identifier)
        profileTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        profileTableView.tableFooterView = UIView()
        profileTableView.estimatedRowHeight = UITableView.automaticDimension
        profileTableView.reloadData()
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

extension BusinessProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell : BusinessProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: BusinessProfileTableViewCell.identifier) as? BusinessProfileTableViewCell else { return UITableViewCell() }
            cell.setValue(vendorProfile: vendorProfile)
            return cell
        case 1,2,3,4:
            guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
            cell.setVendorValue(vendorProfile : vendorProfile, index: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension BusinessProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Utility.dynamicSize(250)
        case 1,2,3,4:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

extension BusinessProfileViewController {
    func requestVenProfile() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "vendorid" : inbox?.vendorid ?? "",
        ]
        inboxViewModel.requestVenProfile(input: params) { (result: VendorProfile_Base?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.vendorProfile = result
                    doOnMain {
                        self.profileTableView.reloadData()
                    }
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "Try again")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
