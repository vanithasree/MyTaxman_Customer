//
//  CompletedJobTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CompletedJobTableViewCell: UITableViewCell {
    
    @IBOutlet var objectContainerView: UIView!
    @IBOutlet var reviewTableView: UITableView!
    @IBOutlet var jobNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    var menuAction : (() ->Void)?

    var reviewList : [Rmsg] = []{
        didSet{
            doOnMain {
                self.reviewTableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCellViewUI() {
        objectContainerView.setCardView()
        
        jobNameLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .natural)
        
        statusLabel.setLabelCustomProperties(titleText: "Reviewed", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0)), numberOfLines: 1, alignment: .left)
        
        reviewTableView.register(JobCompletedReviewTableViewCell.nib, forCellReuseIdentifier: JobCompletedReviewTableViewCell.identifier)
        //        jobTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.tableFooterView = UIView()
        reviewTableView.backgroundColor = .clear
        reviewTableView.separatorStyle = .none
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        self.reviewList = []
    }
    
    func setValue(data: Ilist) {
        jobNameLabel.text = data.category ?? ""
        self.reviewList = data.rmsg ?? []
        doOnMain {
            self.reviewTableView.reloadData()
        }
    }
    
    @IBAction func didTapMenuAction(_ sender: Any) {
        menuAction?()
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension CompletedJobTableViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : JobCompletedReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: JobCompletedReviewTableViewCell.identifier) as? JobCompletedReviewTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setValue(data: reviewList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
