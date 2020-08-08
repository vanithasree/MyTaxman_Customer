//
//  BusinessProfileTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 04/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class BusinessProfileTableViewCell: UITableViewCell {
    @IBOutlet var bgView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var jobsWonLabel: UILabel!
    
    @IBOutlet var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
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
    
    func setupViews(){
        
        doOnMain {
            self.profileImageView.cornerRadius = self.profileImageView.frame.width / 2
        }
        nameLabel.font  = UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))
        nameLabel.text = ""
        
        statusLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        statusLabel.backgroundColor = ColorManager.liteBGTheme.color
        statusLabel.cornerRadius = 5
        statusLabel.text = " featured "
        statusLabel.textColor = ColorManager.darkTheme.color
        
        ratingLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        ratingLabel.textColor = ColorManager.lightGrey.color
        ratingLabel.text = "0\navg rating"
        let ratingAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: ratingLabel.text ?? "")
        ratingAttributedString.setColorForText(textForAttribute: "0", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        ratingAttributedString.setLineSpaceForText(lineSpace: 3, alignment: ratingLabel.textAlignment)
        ratingLabel.attributedText = ratingAttributedString
        
        reviewLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        reviewLabel.textColor = ColorManager.lightGrey.color
        reviewLabel.text = "0\nreviews"
        let reviewAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: reviewLabel.text ?? "")
        reviewAttributedString.setColorForText(textForAttribute: "0", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        reviewAttributedString.setLineSpaceForText(lineSpace: 3, alignment: reviewLabel.textAlignment)
        reviewLabel.attributedText = reviewAttributedString
        
        jobsWonLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        jobsWonLabel.textColor = ColorManager.lightGrey.color
        jobsWonLabel.text = "0\njobs won"
        let jobsWonAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: jobsWonLabel.text ?? "")
        jobsWonAttributedString.setColorForText(textForAttribute: "0", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        jobsWonAttributedString.setLineSpaceForText(lineSpace: 3, alignment: jobsWonLabel.textAlignment)
        jobsWonLabel.attributedText = jobsWonAttributedString
        
    }
    
    func setValue(vendorProfile : VendorProfile_Base?) {
        
        profileImageView.load(from: vendorProfile?.profile_pic ?? "")
        
        nameLabel.text = vendorProfile?.desc?.first?.vendorname ?? ""
        
        
        
        if let isFeaturedValue = vendorProfile?.desc?.first?.featured,!isFeaturedValue.isEmpty ,isFeaturedValue == "Yes" {
            statusLabel.isHidden = false
        }
        else {
            statusLabel.isHidden = true
        }
        
        
        //  statusLabel.isHidden = vendorProfile?.desc?.first?.featured
        
        ratingLabel.text = "\(vendorProfile?.average_Rating?.first?.average_rating ?? "0")\navg rating"
        let ratingAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: ratingLabel.text ?? "")
        ratingAttributedString.setColorForText(textForAttribute: "\(vendorProfile?.average_Rating?.first?.average_rating ?? "0")", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        ratingAttributedString.setLineSpaceForText(lineSpace: 3, alignment: ratingLabel.textAlignment)
        ratingLabel.attributedText = ratingAttributedString
        
        reviewLabel.text = "\(vendorProfile?.review_Count?.first?.review_count ?? "0")\nreviews"
        let reviewAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: reviewLabel.text ?? "")
        reviewAttributedString.setColorForText(textForAttribute: "\(vendorProfile?.review_Count?.first?.review_count ?? "0")", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        reviewAttributedString.setLineSpaceForText(lineSpace: 3, alignment: reviewLabel.textAlignment)
        reviewLabel.attributedText = reviewAttributedString
        
        jobsWonLabel.text = "\(vendorProfile?.job_Won?.first?.jobwon_count ?? "0")\njobs won"
        let jobsWonAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: jobsWonLabel.text ?? "")
        jobsWonAttributedString.setColorForText(textForAttribute: "\(vendorProfile?.job_Won?.first?.jobwon_count ?? "0")", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(16.0))!)
        jobsWonAttributedString.setLineSpaceForText(lineSpace: 3, alignment: jobsWonLabel.textAlignment)
        jobsWonLabel.attributedText = jobsWonAttributedString
        
    }
}
