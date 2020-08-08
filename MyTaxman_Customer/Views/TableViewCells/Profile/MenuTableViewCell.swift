//
//  MenuTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupViews(){
        menuLabel.textColor = ColorManager.darkText.color
        menuLabel.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        menuLabel.numberOfLines = 0
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setMenu(item : MenuItem){
        menuLabel.text = item.title
        if item.title == "Change Password" {
            menuLabel.text = "\(item.title ?? "")\nLast Changed on "
            let balanceAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: menuLabel.text ?? "")
            balanceAttributedString.setColorForText(textForAttribute: "Last Changed on", withColor: ColorManager.darkText.color, withFont: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))!)
            balanceAttributedString.setLineSpaceForText(lineSpace: 5, alignment: menuLabel.textAlignment)
            menuLabel.attributedText = balanceAttributedString
        }
    }
}
