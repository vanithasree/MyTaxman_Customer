//
//  JobsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit


class JobsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteTitleLabel: UILabel!
    @IBOutlet weak var onlineUserImageView: UIImageView!
    @IBOutlet weak var quoteStatusMessageLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet var jobTableView: UITableView!
    @IBOutlet var seeMoreButton: UIButton!
    
    var menuAction : (() ->Void)?
    var seemoreAction : (() ->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    @IBAction func onTappedActionBtn(_ sender: UIButton) {
        menuAction?()
    }
    
    @IBAction func didTapSeemoreAction(_ sender: Any) {
        seemoreAction?()
    }
    
    func setCellViewUI() {
        quoteTitleLabel.setMainTitle(titleText: "")
        quoteStatusMessageLabel.setPopupTitle(titleText: "")
        
        jobTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        jobTableView.register(JobNotificationTableViewCell.nib, forCellReuseIdentifier: JobNotificationTableViewCell.identifier)
        jobTableView.rowHeight = UITableView.automaticDimension
        jobTableView.tableFooterView = UIView()
        jobTableView.backgroundColor = ColorManager.white.color
        jobTableView.separatorStyle = .none
        jobTableView.delegate = self
        jobTableView.dataSource = self

        seeMoreButton.setFooterTitle(title: "See more")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setValue(data : Quotes) {
        quoteTitleLabel.text = ""
        onlineUserImageView.load(from: "")
        quoteStatusMessageLabel.text = ""
    }
    
    func setCompleteValue(data : Ilist) {
        quoteTitleLabel.text = ""
        onlineUserImageView.load(from: "")
        quoteStatusMessageLabel.text = ""
    }
        
}

extension JobsTableViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .yellow
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
