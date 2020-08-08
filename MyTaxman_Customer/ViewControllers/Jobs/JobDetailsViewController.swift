//
//  JobDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Apple on 09/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
        // Do any additional setup after loading the view.
    }
    func setViewUI() {
        self.title = "Task Details"
        
        detailTableView.register(JobDetailsTableViewCell.nib, forCellReuseIdentifier: JobDetailsTableViewCell.identifier)
        detailTableView.tableFooterView = UIView()
        detailTableView.backgroundColor = ColorManager.white.color
        detailTableView.separatorStyle = .none
        detailTableView.estimatedRowHeight = 50
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
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
extension JobDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : JobDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobDetailsTableViewCell.identifier) as? JobDetailsTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = ColorManager.lightGrey.color
        //        cell..text = "Test\nlabel"
        //        cell.valueLabel.text = "Value\nlabel"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
