//
//  JobNotificationTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 07/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobNotificationTableViewCell: UITableViewCell {
    @IBOutlet var notificationImageView: UIImageView!
    @IBOutlet var notificationLabel: UILabel!
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
    }
}
