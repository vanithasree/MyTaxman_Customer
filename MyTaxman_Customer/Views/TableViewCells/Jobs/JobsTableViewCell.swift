//
//  JobsTableViewCell.swift
//  MyTaxman_Customer
//
//  Created by Apple on 30/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

protocol JobDetailsActionButtonDelegate : class {
    func onTappedButton( _ tag : Int)
}

class JobsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteTitleLabel: UILabel!
    
    @IBOutlet weak var onlineUserImageView: UIImageView!
    
    @IBOutlet weak var quoteStatusMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var actionBtn: UIButton!
    weak var delegate : JobDetailsActionButtonDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellViewUI()
        // Initialization code
    }
    
    @IBAction func onTappedActionBtn(_ sender: UIButton) {
        delegate?.onTappedButton(sender.tag)
    }
    
    func setCellViewUI() {
        quoteTitleLabel.setMainTitle(titleText: "Test")
        quoteStatusMessageLabel.setPopupTitle(titleText: "Welcome")
    }
    
    func setCellDataForQuoteStatusForZero(quoteData: Quotes) {
     //   quoteTitleLabel.text = quoteData.na
    
        
        
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
