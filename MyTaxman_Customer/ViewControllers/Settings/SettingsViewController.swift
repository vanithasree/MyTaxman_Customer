//
//  SettingsViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

/// Menu item
struct MenuItem {
    let title: String!
}
protocol ApiLoadDelegate {
    func getStatus(value:Bool)
}
class SettingsViewController: BaseViewController {
    
    var menuList : [MenuItem] = [.init(title: "Change Password"),
                                 .init(title: "Notifications"),
                                 .init(title: "Settings")]
    @IBOutlet var profileTableView: UITableView!
    var isNeedtoCallApi: Bool = true
    var delegate: ApiLoadDelegate?
    
    private var settingsViewModel = SettingsViewModel()
    var profileDetails : [CustomerProfileDesc] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        self.getCustomerProfileDetails()
    }
    
    func setupViews() {
        isTransparent = true
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
        profileTableView.register(MenuProfileHeaderView.nib, forHeaderFooterViewReuseIdentifier: MenuProfileHeaderView.identifier)
        profileTableView.estimatedRowHeight = UITableView.automaticDimension
        profileTableView.separatorStyle = .singleLine
        profileTableView.tableFooterView = UIView()
        profileTableView.backgroundColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func getCustomerProfileDetails() {
        if self.isNeedtoCallApi == true {
            LoadingIndicator.shared.show(forView: self.view)
            let params: Parameters = [
                "customerid": UserDetails.shared.userId
            ]
            
            settingsViewModel.getCustProfileDetails(input: params) { (result: CustomerProfileBase?, alert: AlertMessage?) in
                LoadingIndicator.shared.hide()
                if let result = result {
                    if result.code == "1" {
                        self.profileDetails = result.desc ?? []
                        
                    }
                    doOnMain {
                        self.profileTableView.reloadData()
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


extension SettingsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if self.profileDetails.count > 0 {
            if let updatedDate = self.profileDetails.first?.profile_updated_on, !updatedDate.isEmpty {
                
                let date = updatedDate.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                let activityDate = "\(date?.toString(format: "dd MMM yyyy") ?? "")"
                cell.setMenu(item: menuList[indexPath.row], updatedDate: activityDate)
            }
            
        }
        else {
            cell.setMenu(item: menuList[indexPath.row])
        }
        
        
        /*  cell.changePasswordAction = {[weak self] in
         self?.redirectEditProfile()
         }*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuProfileHeaderView.identifier) as? MenuProfileHeaderView else{
            return UIView()
        }
        if self.profileDetails.count > 0 {
            headerView.setCellData(customerDetails: self.profileDetails.first!)
        }
        headerView.editAction = { [weak self] in
            self?.redirectEditProfile()
        }
        
        headerView.backgroundColor = .clear
        
        return headerView
    }
}

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Utility.dynamicSize(300)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.redirectChangePassword()
            break
        case 1:
            self.redirectNotifications()
            break
        case 2:
            self.redirectSettings()
            break
        default:
            break
        }
    }
}

extension SettingsViewController {
    func redirectEditProfile() {
        let editProfileVC = EditProfileViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        editProfileVC.hidesBottomBarWhenPushed = true
        editProfileVC.delegate = self
        editProfileVC.profileDetail = self.profileDetails.first
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    func redirectChangePassword() {
        let passwordVC = ChangePasswordViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        passwordVC.hidesBottomBarWhenPushed = true
        passwordVC.profileDetail = self.profileDetails.first
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
    
    func redirectNotifications() {
        let notificationVC = NotificationsViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        notificationVC.hidesBottomBarWhenPushed = true
        notificationVC.profileDetail = self.profileDetails.first
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func redirectSettings() {
        let settingListVC = SettingListViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        settingListVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingListVC, animated: true)
    }
}

extension SettingsViewController : ApiLoadDelegate {
    func getStatus(value: Bool) {
        self.isNeedtoCallApi = value
        self.getCustomerProfileDetails()
    }
}
