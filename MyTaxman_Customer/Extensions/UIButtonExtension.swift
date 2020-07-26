//
//  UIButtonExtension.swift
//  jps
//
//  Created by vijaykarthik on 17/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /* func setDynamicFontSizeButton() {
     NotificationCenter.default.addObserver(self, selector: #selector(setButtonDynamicFontSize), name: UIContentSizeCategory.didChangeNotification, object: nil)
     }
     
     @objc func setButtonDynamicFontSize() {
     setDarkBlueTheme(btn: self, title: self.titleLabel?.text ?? "")
     setLiteBlueTheme(btn: self, title: self.titleLabel?.text ?? "")
     
     
     }*/
    
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
    
    func setDarkGreenTheme(btn:UIButton, title:String) {
        
        btn.backgroundColor = ColorManager.darkTheme.color
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(ColorManager.white.color, for: .normal)
//        btn.applyCornerRadius(amount: 5)
        btn.titleLabel?.font =  UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0))
        btn.titleLabel?.adjustsFontForContentSizeCategory = false
        
    }
    
    func setOptionChooseTheme(btn:UIButton, title:String) {
        
        btn.backgroundColor = .white
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(ColorManager.darkText.color, for: .normal)
        btn.titleLabel?.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(16.0))
        btn.titleLabel?.adjustsFontForContentSizeCategory = false
        
    }
    
    func setFooterTitle(title:String) {
        
        self.backgroundColor = .white
        self.setTitle(title, for: .normal)
        self.setTitleColor(ColorManager.darkGrey.color, for: .normal)
        self.titleLabel?.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(14.0))
        self.titleLabel?.adjustsFontForContentSizeCategory = false
        
    }
    
    func setButtonProperties(title:String, font:UIFont?,titleColor:UIColor) {
        self.backgroundColor = .clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.titleLabel?.adjustsFontForContentSizeCategory = false
    }
    
    func setGreyBorderColor() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ColorManager.borderColor.color.cgColor
        self.layer.masksToBounds = true
    }
    
    func setClearBorderColor() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
    func applyCornerRadius(amount:CGFloat) {
        
        self.layer.cornerRadius = amount
        self.layer.masksToBounds = true
        
    }
    func setCornerRadius(amount: CGFloat, withBorderAmount borderWidthAmount: CGFloat, andColor borderColor: UIColor) {
        
        self.layer.cornerRadius = amount
        self.layer.borderWidth = borderWidthAmount
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
        
    }
    
    func underline(text: String, color : UIColor) {
        //        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}
