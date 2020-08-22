//
//  CompletedJobTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FloatRatingView
class CompletedJobTableViewCell: UITableViewCell {
    
    @IBOutlet var objectContainerView: UIView!
    @IBOutlet var jobNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    var menuAction : (() ->Void)?
    @IBOutlet var reviewTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ratingView: FloatRatingView!
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
        
        statusLabel.setLabelCustomProperties(titleText: "Reviewed", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .left)
        
        reviewTitleLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font:  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0)), numberOfLines: 1, alignment: .left)
        
        descriptionLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        descriptionLabel.numberOfLines = 0
        
        ratingView.backgroundColor = UIColor.clear
        ratingView.tintColor = .yellow
        ratingView.type = .wholeRatings
    }
    
    func setValue(data: Ilist) {
        jobNameLabel.text = data.category ?? ""
        reviewTitleLabel.text = "Review left for \(data.vendorname ?? "")"
        ratingView.rating = Double(data.star_given ?? "0") ?? 0
        descriptionLabel.text = data.review ?? ""
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

