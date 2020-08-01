//
//  ChatViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews(){
        chatTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        chatTableView.tableFooterView = UIView()
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

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) else { return UITableViewCell() }
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(60)
    }
}
