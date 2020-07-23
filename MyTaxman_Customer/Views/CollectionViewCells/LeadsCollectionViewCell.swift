//
//  LeadsCollectionViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LeadsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceNameTitleLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellViewUI()
    }
    
    func setCellViewUI() {
        
    }
    
    func setCellData(value:ServicesList) {
        serviceNameTitleLabel.text = value.title
        serviceImageView.image = UIImage(named: value.imageName)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
