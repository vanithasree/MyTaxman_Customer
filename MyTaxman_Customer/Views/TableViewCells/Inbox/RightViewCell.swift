//
//  RightViewCell.swift
//  ChatSample
//
//  Created by Hafiz on 20/09/2019.
//  Copyright © 2019 Nibs. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.cornerRadius = 12
        messageContainerView.backgroundColor = UIColor(hexString: "E1F7CB")
        
        timeLabel.adjustsFontSizeToFitWidth = true

        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(data: Chat) {
        textMessageLabel.text = data.message
        timeLabel.text = (data.sent_on ?? "").toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.toString(format: "hh:mm a") ?? ""
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
