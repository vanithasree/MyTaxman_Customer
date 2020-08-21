//
//  MenuProfileHeaderView.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class MenuProfileHeaderView: UITableViewHeaderFooterView {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    // @IBOutlet var mobileNumberLabel: UILabel!
    //    @IBOutlet var editButton: UIButton!
    //    var editAction : (() ->Void)?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    func setupViews() {
        self.nameLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font: UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .center)
        self.emailLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkText.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(15.0)), numberOfLines: 0, alignment: .center)
        
    }
    
    func setCellData(customerDetails : CustomerProfileDesc) {
        
        nameLabel.text = customerDetails.customername ?? ""
        emailLabel.text = customerDetails.email ?? ""
        /*   if let profilePic = customerDetails.profile_pic, !profilePic.isEmpty {
         profileImageView.load(from: Constant.imageBaseUrlString + profilePic)
         }
         else {
         profileImageView.image = UIImage(named: "profile")
         }*/
        
        
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    /* @IBAction func didTapEditAction(_ sender: Any) {
     editAction?()
     }*/
}
