//
//  ColorManager.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

// Usage Examples
enum ColorManager {
    
    case darkTheme
    case mediumTheme
    case liteTheme
    
    case liteBGTheme
    case darkBGTheme
    
    case textColor
    case titleColor
    case borderColor
    
    case darkText
    case darkGrey
    case lightGrey
    case lightText
    case white
    case backgroundGrey
    
    case textThickDarkGreenColor
    case textDarkGreenColor
    case textLiteGreenColor
    case textVeryLiteGreenColor
    
    
    case custom(hexString: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.color.withAlphaComponent(CGFloat(alpha))
    }
}

extension ColorManager {
    
    var color: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
            
        case .darkTheme:
            instanceColor = UIColor(hexString: "#05888B")
        case .mediumTheme:
            instanceColor = UIColor(hexString: "#13B3C4")
        case .liteTheme:
            instanceColor = UIColor(hexString: "#6CD3DE")
            
        case .liteBGTheme:
            instanceColor = UIColor(hexString: "#C4F9FF")
        case .darkBGTheme:
            instanceColor = UIColor(hexString: "#13B3C4")
            
            
            
            
        case .textThickDarkGreenColor:
            instanceColor = UIColor(hexString: "#0F2A31")
        case .textDarkGreenColor:
            instanceColor = UIColor(hexString: "#044657")
        case .textLiteGreenColor:
             instanceColor = UIColor(hexString: "#13B3C4")
        case .textVeryLiteGreenColor:
             instanceColor = UIColor(hexString: "#C4F9FF")
            
            
            
            
        case .darkText:
            instanceColor = UIColor(hexString: "#2d3958")
        case .lightText:
            instanceColor = UIColor(hexString: "#7b88a8")
            
        case .backgroundGrey:
            instanceColor = UIColor(hexString: "#f5f5f9")
        case .textColor:
            instanceColor = UIColor(named: "textColor")!
        case .titleColor:
            instanceColor = UIColor(named: "titleColor")!
        case .borderColor:
            instanceColor = UIColor.lightGray.withAlphaComponent(0.7)
        case .white:
            instanceColor = UIColor.white
            
        case .darkGrey:
            instanceColor = UIColor.darkGray
            
        case .lightGrey:
            instanceColor = UIColor.lightGray
            
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
            
        }
        return instanceColor
    }
}

extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
