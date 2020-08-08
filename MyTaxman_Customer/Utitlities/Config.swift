//
//  Config.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

enum Constant {
    static let minLineSpacing: CGFloat = 2.0
    
    static let minItemSpacing: CGFloat = 2.0
    
    static let offset: CGFloat = 2.0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat , column :CGFloat) -> CGFloat {
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        return totalWidth / column
    }
    
    static let devURLBaseString = "http://sunrisetechs.com/demo/MyTaxman/index.php"
    static let imageBaseUrlString = "http://sunrisetechs.com/demo/MyTaxman/"
    
    static let k_deviceToken = "k_deviceToken"
    
}
