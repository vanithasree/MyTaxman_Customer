//
//  QuoteTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 07/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FloatRatingView
class JobQuoteTableViewCell: UITableViewCell {

    @IBOutlet var ratingView: FloatRatingView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
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
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setCellViewUI() {
        profileImageView.contentMode = .scaleAspectFill
        doOnMain {
            self.profileImageView.cornerRadius = self.profileImageView.frame.size.width / 2
        }
        nameLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
        statusLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
        descriptionLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
        
        ratingView.backgroundColor = UIColor.clear
        ratingView.tintColor = .yellow
        ratingView.type = .wholeRatings
    }
    
    func setValue(data: Vendor){
        nameLabel.text = data.vendorname ?? ""
        statusLabel.text = data.featured ?? "" == "Yes" ? "Featured" : ""
        profileImageView.load(from: "\(data.baseurl ?? "")\(data.profile_pic ?? "")")
        descriptionLabel.text = data.additional_comments ?? ""
        ratingView.rating = Double(data.vendor_avg_rating ?? "0") ?? 0
    }
}
