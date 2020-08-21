//
//  SettingListViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

enum settingPageType : Int
{
    case about = 1
    case help = 2
    case terms = 3
    case none
}
class SettingListViewController: UIViewController {
    
    @IBOutlet var settingListTableView: UITableView!
    var menuList : [MenuItem] = [.init(title: "About"),
                                 .init(title: "Help"),
                                 .init(title: "Terms and Conditions"),
                                 .init(title: "Logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        
        self.title = "Settings"
        
        settingListTableView.delegate = self
        settingListTableView.dataSource = self
        settingListTableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
        settingListTableView.estimatedRowHeight = UITableView.automaticDimension
        settingListTableView.tableFooterView = UIView()
        settingListTableView.backgroundColor = .clear
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

extension SettingListViewController : UITableViewDataSource {
    
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
}

extension SettingListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (menuList.count - 1) {
            self.logoutAction()
        }else {
            switch indexPath.row {
            case 0:
                self.redirectDetailsPage(pageType: .about)
                break
            case 1:
                self.redirectDetailsPage(pageType: .help)
                break
            case 2:
                self.redirectDetailsPage(pageType: .terms)
                break
            default:
                break
            }
        }
    }
}
extension SettingListViewController {
    func redirectDetailsPage(pageType: settingPageType) {
        let detailVC = SettingDetailViewController.instantiateFromAppStoryboard(appStoryboard: .Settings)
        detailVC.pageType = pageType
        switch pageType {
        case .about:
            detailVC.urlString = Constant.imageBaseUrlString+"connect/Mytaxman/home/terms"
        case .terms:
            detailVC.urlString = Constant.imageBaseUrlString+"connect/Mytaxman/home/terms"
        case .help:
            detailVC.urlString = Constant.imageBaseUrlString+"connect/Mytaxman/"
        default:
            break
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func logoutAction(){
        doOnMain {
            let actionSheet = UIAlertController(title: "", message: "You may miss to receive updates. Are you sure to sign out?", preferredStyle: .actionSheet)
            let logout = UIAlertAction(title: "Logout", style: .destructive) { (_) in
                self.redirectWelcomePage()
            }
            actionSheet.addAction(logout)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
            actionSheet.addAction(cancel)
            self.present(actionSheet, animated: true, completion: {})
        }
    }
    
    fileprivate func redirectWelcomePage() {
        UserDetails.shared.logout()
        doOnMain {
            let welcomeVC = GetStartedViewController.instantiateFromAppStoryboard(appStoryboard: .Auth)
            let navigatinC = UINavigationController(rootViewController: welcomeVC)
            navigatinC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigatinC, animated: true, completion: {})
        }
    }
}
