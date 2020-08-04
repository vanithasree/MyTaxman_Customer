//
//  NoDataView.swift
//  jps
//
//  Created by Prem kumar on 26/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    @IBOutlet var bgView: UIView!
    @IBOutlet var noDataLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    func setupViews(){
        noDataLabel.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        noDataLabel.textColor = ColorManager.darkText.color
        noDataLabel.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 0)
    }
    
    func setData(information : String){
        noDataLabel.text = information
    }
}
