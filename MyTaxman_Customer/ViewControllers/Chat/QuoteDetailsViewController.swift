//
//  QuoteDetailsViewController.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
struct QuoteDetail {
    let title: String!
}
class QuoteDetailsViewController: UIViewController {
    @IBOutlet var quoteTableView: UITableView!
    var inbox: Inboxlist?
    var quoteDetailList : [QuoteDetail] = [.init(title: "Flat Estimated Cost"),
                                           .init(title: "Site Inspection"),
                                           .init(title: "More Info"),
                                           .init(title: "Additional Info"),
                                           .init(title: "Quote Received On"),
                                          ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews(){
        quoteTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        quoteTableView.tableFooterView = UIView()
        quoteTableView.reloadData()
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

extension QuoteDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else { return UITableViewCell() }
        cell.setValue(data: quoteDetailList[indexPath.row], index: indexPath.row, inbox: inbox)
        return cell
    }
}

extension QuoteDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(60)
    }
}
