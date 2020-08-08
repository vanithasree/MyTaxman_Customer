//
//  JobsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit


class JobsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quoteTitleLabel: UILabel!
    @IBOutlet weak var onlineUserImageView: UIImageView!
    @IBOutlet weak var quoteStatusMessageLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet var jobTableView: UITableView!
    @IBOutlet var seeMoreButton: UIButton!
    
    var isFromTabIdentityValue : Int = 0
    
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
        objectContainerView.setCardView()
        objectContainerView.backgroundColor = .white
        
        quoteTitleLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 0, alignment: .natural)
        quoteStatusMessageLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0)), numberOfLines: 1, alignment: .left)
        descriptionLabel.setCaptionTitle(titleText: "")
        
        jobTableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.identifier)
        jobTableView.register(JobNotificationTableViewCell.nib, forCellReuseIdentifier: JobNotificationTableViewCell.identifier)
        jobTableView.register(ClosedJobTableViewCell.nib, forCellReuseIdentifier: ClosedJobTableViewCell.identifier)
        
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
    
    func setClosedListValue(data : Quotes) {
        quoteTitleLabel.text = data.category ?? ""
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        
        if let value = data.cancel_description, !value.isEmpty {
            descriptionLabel.text = "Reason: \(value)"
        }
        else {
            descriptionLabel.text = "Reason: "
        }
        
        quoteStatusMessageLabel.text = "EXPIRED"
        
        self.isFromTabIdentityValue = 3
        self.jobTableView.reloadData()
    }
    
    func setValue(data : Quotes) {
        quoteTitleLabel.text = data.category ?? ""
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        descriptionLabel.text = ""
        let taskStatus = data.task_status ?? "0"
        let quoteStatus = data.vendor?.first?.quote_status ?? "0"
        var statusString : String = ""
        
        switch (taskStatus, quoteStatus) {
        case ("0", "0"):
            statusString = "OPEN FOR QUOTES"
        case ("0", "1"):
            statusString = "HIRED"
        case ("0", "2"):
            statusString = "DECLINED"
        case ("0", "3"):
            statusString = "EXPIRED"
        default: break
            
        }
        quoteStatusMessageLabel.text = statusString
        self.isFromTabIdentityValue = 1
        self.jobTableView.reloadData()
    }
    
    func setCompleteValue(data : Ilist) {
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        quoteTitleLabel.text = data.category ?? ""
        quoteStatusMessageLabel.text = "REVIEWED"
        descriptionLabel.text = ""
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
        
        switch self.isFromTabIdentityValue {
        case 3:
            guard let cell : ClosedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: ClosedJobTableViewCell.identifier) as? ClosedJobTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .yellow
            cell.selectionStyle = .none
            return cell
            
        default:
            guard let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier) as? QuoteTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .yellow
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
