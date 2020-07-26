//
//  AddressTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 26/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var addresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addresLabel.setPopupTitle(titleText: "")
        addresLabel.numberOfLines = 0
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
    
}
