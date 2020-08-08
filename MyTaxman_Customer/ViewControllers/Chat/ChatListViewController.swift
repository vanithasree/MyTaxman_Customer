//
//  ChatListViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 25/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire
class ChatListViewController: UIViewController {
    
    @IBOutlet var chatTableView: UITableView!
    private var inboxViewModel = InboxViewModel()
    var inboxList: [Inboxlist] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inbox"
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        requestCusinboxlist()
    }
    
    func setupViews(){
        chatTableView.register(ChatTableViewCell.nib, forCellReuseIdentifier: ChatTableViewCell.identifier)
        chatTableView.tableFooterView = UIView()
        chatTableView.backgroundColor = ColorManager.white.color
        chatTableView.reloadData()
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

extension ChatListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (inboxList.count > 0){
            tableView.backgroundView = nil
            return 1
        }
        let noDataView : NoDataView = UIView.fromNib()
        noDataView.frame = tableView.bounds
        tableView.backgroundView = noDataView
        noDataView.setData(information: "You can start messaging with a business once they have sent you a quote")
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as? ChatTableViewCell else { return UITableViewCell() }
        cell.setValue(data: inboxList[indexPath.row])
        return cell
    }
    
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(100)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inboxDetailsVC = InboxDetailsViewController.instantiateFromAppStoryboard(appStoryboard: .Inbox)
        inboxDetailsVC.hidesBottomBarWhenPushed = true
        inboxDetailsVC.inbox = inboxList[indexPath.row]
        self.navigationController?.pushViewController(inboxDetailsVC, animated: true)
    }
}

extension ChatListViewController {
    func requestCusinboxlist() {
        LoadingIndicator.shared.show(forView: self.view)
        let params: Parameters = [
            "customerid": UserDetails.shared.userId ,
        ]
        inboxViewModel.requestCusinboxlist(input: params) { (result: InboxListBase?, alert: AlertMessage?) in
            LoadingIndicator.shared.hide()
            if let result = result {
                if let success = result.code, success == "1" {
                    self.inboxList = result.desc?.ilist ?? []
                    doOnMain {
                        self.chatTableView.reloadData()
                    }
                }else{
                    print("No response found.")
                    self.presentAlert(withTitle: error, message: "")
                }
            } else if let alert = alert {
                self.presentAlert(withTitle: "", message: alert.errorMessage)
            }
        }
    }
}
