//
//  QuoteTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 01/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var subTitleLabel: UILabel!
    
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
        titleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        
//        subTitleLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
//        subTitleLabel.textColor = ColorManager.lightGrey.color
    }
    
    func setValue(data: QuoteDetail, index: Int, inbox: Inboxlist?){
        var text = ""
        switch index {
        case 0:
            text = (inbox?.cost_estimate_flat ?? "").isBlank ? "$0" : "$\(inbox?.cost_estimate_flat ?? "0")"
            break
        case 1:
            text = inbox?.site_inspection ?? ""
            break
        case 2:
            text = inbox?.more_information ?? ""
            break
        case 3:
            text = inbox?.additional_comments ?? "-"
            break
        case 4:
            text = (inbox?.quote_accepted_on ?? "").toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.toString(format: "dd MMM yyyy") ?? ""
            break
        default:
            break
        }
        titleLabel.text = "\(data.title ?? "")\n\(text)"
        let balanceAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: titleLabel.text ?? "")
        balanceAttributedString.setColorForText(textForAttribute: "\(text)", withColor: ColorManager.lightGrey.color, withFont: UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))!)
        balanceAttributedString.setLineSpaceForText(lineSpace: 3, alignment: titleLabel.textAlignment)
        titleLabel.attributedText = balanceAttributedString
    }
}
