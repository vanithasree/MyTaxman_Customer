//
//  JobsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
enum JobType {
    case active
    case completed
    case closed
}

class JobsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var objectContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quoteTitleLabel: UILabel!
    @IBOutlet weak var onlineUserImageView: UIImageView!
    @IBOutlet weak var quoteStatusMessageLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet var jobTableView: UITableView!
    @IBOutlet var seeMoreButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet var notifcationImageView: UIImageView!
    @IBOutlet var notificationHeightConstraints: NSLayoutConstraint!
    @IBOutlet var jobListHeightConstraints: NSLayoutConstraint!
    var menuAction : (() ->Void)?
    var no_of_vendor_count : String = ""
    var jobType : JobType = .active
    
    var vendorList : [Vendor] = [] {
        didSet {
            self.listUpdateConstraints(height: CGFloat(self.vendorList.count * 120))
            doOnMain {
                self.jobTableView.reloadData()
            }
        }
    }
    
    var isSeemore : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    func listUpdateConstraints(height: CGFloat) {
        doOnMain {
            self.jobListHeightConstraints.constant = height
            self.jobListHeightConstraints.isActive = true
        }
    }
    
    @IBAction func onTappedActionBtn(_ sender: UIButton) {
        menuAction?()
    }
    
    @IBAction func didTapSeemoreAction(_ sender: UIButton) {
        isSeemore = !isSeemore
        if isSeemore {
            print("selected")
            displaySeemore(show: true)
            seeMoreButton.setTitle("See less", for: .normal)
            notificationLabel.text = "\(no_of_vendor_count) experts notified of your job"
        }else {
            print("un selected")
            displaySeemore(show: false)
            notificationLabel.text = ""
            seeMoreButton.setTitle("See more", for: .normal)
        }
    }
    
    func setCellViewUI() {
        objectContainerView.setCardView()
        objectContainerView.backgroundColor = .white
        
        quoteTitleLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .natural)
        quoteStatusMessageLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0)), numberOfLines: 1, alignment: .left)
        descriptionLabel.setCaptionTitle(titleText: "")
        descriptionLabel.numberOfLines = 1
        
        jobTableView.register(JobQuoteTableViewCell.nib, forCellReuseIdentifier: JobQuoteTableViewCell.identifier)
        jobTableView.register(JobNotificationTableViewCell.nib, forCellReuseIdentifier: JobNotificationTableViewCell.identifier)
        jobTableView.register(ClosedJobTableViewCell.nib, forCellReuseIdentifier: ClosedJobTableViewCell.identifier)
        
        jobTableView.rowHeight = UITableView.automaticDimension
        jobTableView.tableFooterView = UIView()
        jobTableView.backgroundColor = ColorManager.white.color
        jobTableView.separatorStyle = .none
        jobTableView.delegate = self
        jobTableView.dataSource = self
        
        vendorList = []
        
        seeMoreButton.setFooterTitle(title: "")
        seeMoreButton.setTitleColor(ColorManager.mediumTheme.color, for: .normal)
        
        notificationLabel.setCaptionTitle(titleText: "")
        notificationLabel.numberOfLines = 0
        displaySeemore(show: false)
//        listUpdateConstraints(height: 0)
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
    
    func displaySeemore(show: Bool) {
        doOnMain {
            self.notificationHeightConstraints.constant = show ? 25 : 0
            self.notificationHeightConstraints.isActive = true
        }
    }
    
    func setClosedListValue(data : Quotes) {
        vendorList = []
        jobType = .closed
        quoteTitleLabel.text = data.category ?? ""
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        if let value = data.cancel_description, !value.isEmpty {
            descriptionLabel.text = "Reason: \(value)"
        }else {
            descriptionLabel.text = "Reason: "
        }
        quoteStatusMessageLabel.text = "EXPIRED"
        listUpdateConstraints(height: 0)
        doOnMain {
            self.jobTableView.reloadData()
        }
    }
    
    func setValue(data : Quotes) {
        vendorList = data.vendor ?? []
        jobType = .active
        quoteTitleLabel.text = data.category ?? ""
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        descriptionLabel.text = data.description ?? ""
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
        seeMoreButton.setTitle("See more", for: .normal)
        displaySeemore(show: false)
    }
    
    func setCompleteValue(data : Ilist) {
        vendorList = []
        jobType = .completed
        onlineUserImageView.image = UIImage(named: "RadioSelected")
        quoteTitleLabel.text = data.category ?? ""
        quoteStatusMessageLabel.text = "REVIEWED"
        descriptionLabel.text = ""
        listUpdateConstraints(height: 0)
        doOnMain {
            self.jobTableView.reloadData()
        }
    }
}

extension JobsTableViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch jobType {
        case .active:
            return vendorList.count
        case .completed:
            return 0
        case .closed:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch jobType {
        case .active:
            guard let cell : JobQuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobQuoteTableViewCell.identifier) as? JobQuoteTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .yellow
            cell.selectionStyle = .none
            if vendorList.count > indexPath.row {
                cell.setValue(data: vendorList[indexPath.row])
            }
            return cell
            
        case .completed:
            return UITableViewCell()
        case .closed:
            guard let cell : ClosedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: ClosedJobTableViewCell.identifier) as? ClosedJobTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .yellow
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch jobType {
        case .active:
            return 100
        case .completed:
            return UITableView.automaticDimension
        case .closed:
            return UITableView.automaticDimension
        }
    }
}
