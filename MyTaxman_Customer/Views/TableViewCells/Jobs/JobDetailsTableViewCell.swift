//
//  JobDetailsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 09/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userStatusImageView: UIImageView!
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
       // titleLabel.setMainTitle(titleText: "")
        //valueLabel.setPopupTitle(titleText: "")
        
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
