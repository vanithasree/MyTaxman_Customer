//
//  SettingsViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
/// Menu item
struct MenuItem {
    let title: String!
}
class SettingsViewController: UIViewController {
    
    var menuList : [MenuItem] = [.init(title: "Change Password"),
                                 .init(title: "Notifications"),
                                 .init(title: "Settings")]
    @IBOutlet var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
        profileTableView.register(MenuProfileHeaderView.nib, forHeaderFooterViewReuseIdentifier: MenuProfileHeaderView.identifier)
        profileTableView.estimatedRowHeight = UITableView.automaticDimension
        profileTableView.separatorStyle = .none
        profileTableView.tableFooterView = UIView()
        profileTableView.backgroundColor = .clear
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
        cell.setMenu(item: menuList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuProfileHeaderView.identifier) as? MenuProfileHeaderView else{
            return UIView()
        }
        headerView.backgroundColor = .clear
        headerView.editAction = {[weak self] in
            self?.redirectEditProfile()
        }
        return headerView
    }
}

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    func redirectChangePassword() {
        let passwordVC = ChangePasswordViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        passwordVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
    
    func redirectNotifications() {
        let notificationVC = NotificationsViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        notificationVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func redirectSettings() {
        let settingListVC = SettingListViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        settingListVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingListVC, animated: true)
    }
}
