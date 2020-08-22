//
//  JobDetailsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 09/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabelLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var statusImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userStatusImageView: UIImageView!
    
    var editBtnClicked : (() ->Void)?
    
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
        
        self.titleLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkGrey.color, font: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(17.0)), numberOfLines: 1, alignment: .left)
        self.valueLabel.setLabelCustomProperties(titleText: "", textColor: ColorManager.darkGrey.color, font: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0)), numberOfLines: 1, alignment: .left)
        
    }
    
    @IBAction func onTappedEditBtn(_ sender: UIButton) {
        editBtnClicked?()
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
