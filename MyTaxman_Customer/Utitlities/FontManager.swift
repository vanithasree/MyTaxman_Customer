//
//  FontManager.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

// Usage Examples


struct Font {
    
    enum FontName : String {
        
        case PoppinsRegular = "Poppins-Regular"
        case PoppinsSemiBold = "Poppins-SemiBold"
        case PoppinsBlack = "Poppins-Black"
        case PoppinsItalic = "Poppins-Italic"
        case PoppinsBold = "Poppins-Bold"
        case PoppinsLight = "Poppins-Light"
        case PoppinsExtraLight = "Poppins-ExtraLight"
        case PoppinsThin = "Poppins-Thin"
        case PoppinsMedium = "Poppins-Medium"
    }
}


class Utility {
    /// Logs all available fonts from iOS SDK and installed custom font
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    class func dynamicSize(_ Size : CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let calculatedFontSize = screenWidth / 414 * Size   // 414 -> 8 plus points
        return calculatedFontSize
    }
    
    /// Get the Scaled version of your UIFont.
    ///
    /// - Parameters:
    ///   - name: Name of the UIFont whose scaled version you wish to obtain.
    ///   - textStyle: The text style for your font, i.e Body, title etc...
    /// - Returns: The scaled UIFont version with the given textStyle
    
    
    /*   func setFontSize(forFont name: Font.FontName, size:CGFloat) -> UIFont {
     
     let screenWidth = UIScreen.main.bounds.size.width
     let calculatedFontSize = screenWidth / 414 * size
     
     guard let customFont = UIFont(name: name.rawValue, size: calculatedFontSize) else {
     fatalError("""
     Failed to load the "\(name.rawValue)" font.
     Make sure the font file is included in the project and the font name is spelled correctly.
     """
     )
     }
     return UIFontMetrics.default.scaledFont(for: customFont)
     }
     
     
     func getScaledFont(forFont name: String, textStyle: UIFont.TextStyle) -> UIFont {
     
     
     var newPointSize: CGFloat = 0.0
     
     switch textStyle {
     case .largeTitle:
     newPointSize = 34.0
     case .title1:
     newPointSize = 28.0
     case .title2:
     newPointSize = 22.0
     case .title3:
     newPointSize = 20.0
     case .headline:
     newPointSize = 17.0
     case .body:
     newPointSize = 17.0
     case .callout:
     newPointSize = 16.0
     case .subheadline:
     newPointSize = 15.0
     case .footnote:
     newPointSize = 13.0
     case .caption1:
     newPointSize = 12.0
     case .caption2:
     newPointSize = 11.0
     
     default:
     
     let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
     newPointSize = userFont.pointSize
     }
     
     
     
     print("Point size ==== \(textStyle.rawValue) \(newPointSize)")
     
     
     let screenWidth = UIScreen.main.bounds.size.width
     let calculatedFontSize = screenWidth / 414 * newPointSize
     
     guard let customFont = UIFont(name: name, size: calculatedFontSize) else {
     fatalError("""
     Failed to load the "\(name)" font.
     Make sure the font file is included in the project and the font name is spelled correctly.
     """
     )
     }
     return UIFontMetrics.default.scaledFont(for: customFont)
     }
     
     func getScaledFont(forFont name: Font.FontName, textStyle: UIFont.TextStyle) -> UIFont {
     
     
     var newPointSize: CGFloat = 0.0
     
     switch textStyle {
     case .largeTitle:
     newPointSize = 34.0
     case .title1:
     newPointSize = 28.0
     case .title2:
     newPointSize = 22.0
     case .title3:
     newPointSize = 20.0
     case .headline:
     newPointSize = 17.0
     case .body:
     newPointSize = 17.0
     case .callout:
     newPointSize = 16.0
     case .subheadline:
     newPointSize = 15.0
     case .footnote:
     newPointSize = 13.0
     case .caption1:
     newPointSize = 12.0
     case .caption2:
     newPointSize = 11.0
     
     default:
     
     let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
     newPointSize = userFont.pointSize
     }
     
     
     
     print("Point size ==== \(textStyle.rawValue) \(newPointSize)")
     
     let screenWidth = UIScreen.main.bounds.size.width
     let calculatedFontSize = screenWidth / 414 * newPointSize
     
     guard let customFont = UIFont(name: name.rawValue, size: calculatedFontSize) else {
     fatalError("""
     Failed to load the "\(name.rawValue)" font.
     Make sure the font file is included in the project and the font name is spelled correctly.
     """
     )
     }
     return UIFontMetrics.default.scaledFont(for: customFont)
     }*/
}

