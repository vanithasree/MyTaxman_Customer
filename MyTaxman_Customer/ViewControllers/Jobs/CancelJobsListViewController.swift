//
//  CancelJobsListViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CancelJobsListViewController: UIViewController {
    @IBOutlet var cancelJobTableView: UITableView!
    
    @IBOutlet var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    @IBAction func didTapCancelAction(_ sender: Any) {
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier) as? OptionTableViewCell else {
            return UITableViewCell()
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
        headerView.titleLabel.text = "Please select a reason below:"
        return headerView
    }
}

extension CancelJobsListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Utility.dynamicSize(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
