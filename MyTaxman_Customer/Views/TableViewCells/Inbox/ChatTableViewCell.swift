//
//  ChatTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobStatusLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var deliveryStatusImageView: UIImageView!
    @IBOutlet var lastMessageLabel: UILabel!
    
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
        
        profileImageView.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.contentMode = .scaleAspectFill
        
        deliveryStatusImageView.contentMode = .scaleAspectFit
        
        nameLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        
        jobStatusLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
        jobStatusLabel.backgroundColor = ColorManager.liteBGTheme.color
        jobStatusLabel.cornerRadius = 5
        
        chatLabel.font  = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        
        lastMessageLabel.font  = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(14.0))
    }
    
    func setValue(data: Inboxlist){
        profileImageView.load(from: data.profile_pic ?? "")
        nameLabel.text = data.vendorname ?? ""
        var quote_status = ""
        switch data.quote_status ?? "" {
        case "0":
            quote_status = "Some one is quoted"
            break
        case "1":
            quote_status = "Hired"
            break
        case "2":
            quote_status = "Customer quotes declined"
            break
        case "3":
            quote_status = "Expired"
            break
        case "4":
            quote_status = "Complete the task"
            break
        default:
            break
        }
        jobStatusLabel.text = " \(quote_status) "
        chatLabel.text = data.business_name ?? ""
        lastMessageLabel.text = data.rmsg?.first?.recent_message ?? ""
    }
}
