//
//  JobCompletedReviewTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FloatRatingView
class JobCompletedReviewTableViewCell: UITableViewCell {
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var ratingView: FloatRatingView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    func setCellViewUI() {
        nameLabel.setLabelCustomProperties(titleText: "", textColor: .black   , font:  UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0)), numberOfLines: 1, alignment: .natural)
        
        commentsLabel.setCaptionTitle(titleText: "")
        commentsLabel.numberOfLines = 2
        
        ratingView.backgroundColor = UIColor.clear
        ratingView.tintColor = .yellow
        ratingView.type = .wholeRatings
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
    
    func setValue(data: Rmsg){
        ratingView.rating = Double(data.avg_rating ?? "0") ?? 0
    }
}
