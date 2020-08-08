//
//  ClosedJobTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Prem kumar on 08/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ClosedJobTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func setValue(){
        
    }
}
