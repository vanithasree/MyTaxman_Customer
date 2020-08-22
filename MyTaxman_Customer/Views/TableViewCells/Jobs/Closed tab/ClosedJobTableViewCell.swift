//
//  ClosedJobTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ClosedJobTableViewCell: UITableViewCell {
    @IBOutlet var jobNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var commentsLabel: UILabel!
    var menuAction : (() ->Void)?
    @IBOutlet var objectContainerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBAction func didTapMenuAction(_ sender: Any) {
        menuAction?()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setCellViewUI() {
        objectContainerView.setCardView()
        
        jobNameLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .natural)
        
        statusLabel.setLabelCustomProperties(titleText: "Expired", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .left)
        
        commentsLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        commentsLabel.numberOfLines = 0
        
    }
    
    func setValue(data: ClosedJobListDesc){
        jobNameLabel.text = data.category ?? ""
        commentsLabel.text = "Reason: \(data.cancel_description ?? "")"
    }
}
