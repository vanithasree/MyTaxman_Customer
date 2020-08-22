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
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var buttonHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet var notificationImageView: UIImageView!
    var menuAction : (() ->Void)?
    var submitAction : (() ->Void)?
    
    var no_of_vendor_count : String = ""
    //    var jobType : JobType = .active
    
    var vendorList : [Vendor] = []{
        didSet{
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    @IBAction func didTapSubmitAction(_ sender: Any) {
        submitAction?()
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
        
        quoteTitleLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .natural)
        quoteStatusMessageLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0)), numberOfLines: 1, alignment: .left)
        
        descriptionLabel.setCaptionTitle(titleText: "")
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        descriptionLabel.textColor = ColorManager.darkText.color

        jobTableView.register(JobQuoteTableViewCell.nib, forCellReuseIdentifier: JobQuoteTableViewCell.identifier)
        jobTableView.tableFooterView = UIView()
        jobTableView.backgroundColor = .clear
        jobTableView.separatorStyle = .none
        jobTableView.delegate = self
        jobTableView.dataSource = self
        
        self.vendorList = []
        
        notificationImageView.image = UIImage(named: "notification_bell")?.withRenderingMode(.alwaysTemplate)
        notificationImageView.tintColor = ColorManager.darkTheme.color
        
        seeMoreButton.setFooterTitle(title: "")
        seeMoreButton.setTitleColor(ColorManager.mediumTheme.color, for: .normal)
        
        notificationLabel.setCaptionTitle(titleText: "")
        notificationLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        notificationLabel.numberOfLines = 0
        
        seeMoreButton.setTitle("See more", for: .normal)
        displaySeemore(show: false)
        //        listUpdateConstraints(height: 0)
        submitButton.setDarkGreenTheme(btn: submitButton, title: "COMPLETE THE TASK")
        doOnMain {
            self.buttonHeightConstraints.constant = 0
            self.buttonHeightConstraints.isActive = true
        }
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
    
    func setValue(data : Quotes) {
        self.vendorList = data.vendor ?? []
        quoteTitleLabel.text = data.category ?? ""
        descriptionLabel.text = data.description ?? ""
        var statusString : String = ""
        let result = data.vendor?.filter({ (obj) -> Bool in
            return obj.quote_status == "1"
        })
        if (result?.count ?? 0 != 0) {
            statusString = "Hired"
        }else {
            if (Int(data.received_quotes ?? "0") ?? 0 >= 4) {
                statusString = "MAX QUOTES RECEIVED"
            }else {
                statusString = "OPEN FOR QUOTES"
            }
        }
        quoteStatusMessageLabel.text = statusString
  
        let completeResult = data.vendor?.filter({ (obj) -> Bool in
            return obj.quote_status == "4"
        })
        if (completeResult?.count ?? 0 != 0 && data.task_status == "0") {
            self.buttonHeightConstraints.constant = CGFloat(44)
            self.buttonHeightConstraints.isActive = true
        }else {
            self.buttonHeightConstraints.constant = CGFloat(0)
            self.buttonHeightConstraints.isActive = true
        }
        let count = data.vendor?.count ?? 0
        self.jobListHeightConstraints.constant = CGFloat(count) * Utility.dynamicSize(120)
        self.jobListHeightConstraints.isActive = true
        doOnMain {
            self.jobTableView.reloadData()
        }
    }
}

extension JobsTableViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : JobQuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobQuoteTableViewCell.identifier) as? JobQuoteTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setValue(data: self.vendorList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utility.dynamicSize(120)
    }
}
