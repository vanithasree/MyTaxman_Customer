//
//  UILabelExtension.swift
//  jps
//
//  Created by Prem kumar on 20/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
   
    
    func underLine(color: UIColor){
        if let text = self.text{
            
            let attributedString = NSMutableAttributedString(string: text)
            //NSAttributedStringKey.foregroundColor : UIColor.blue
            
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: NSRange(location: 0, length: text.count))
            
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.textColor!, range: NSRange(location: 0, length: text.count))
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            
            //            self.setAttributedTitle(attributedString, for: .normal)
            
            //            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            //            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.attributedText = attributedString
        }
    }
    func setPopupTitle(label:UILabel, titleText:String) {
        // label.font = Utility().getScaledFont(forFont: Font.FontName.DMSansRegular.rawValue, textStyle: .body)
        label.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = ColorManager.darkText.color
        label.adjustsFontForContentSizeCategory = false
    }
    
    func setHeaderTitle(label:UILabel, titleText:String) {
        label.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(20.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = false
    }
    
    func setTitleForPageScreenTitle(label:UILabel, titleText:String) {
        label.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(16.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = false
    }
     
    
    
    func setMainTitle(label:UILabel, titleText:String) {
        label.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(18.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = ColorManager.lightGrey.color
        label.adjustsFontForContentSizeCategory = false
    }
    
    func setFooterTitle(label:UILabel,titleText:String) {
        label.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(12.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = ColorManager.darkGrey.color
        label.adjustsFontForContentSizeCategory = false
    }
    
    func setCaptionTitle(label:UILabel,titleText:String) {
        label.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(11.0))
        label.numberOfLines = 0
        label.text = titleText
        label.backgroundColor = .clear
        label.textColor = ColorManager.textColor.color
        label.adjustsFontForContentSizeCategory = false
    }
    
    func setLabelCustomProperties(label:UILabel, titleText:String, textColor:UIColor, font:UIFont?, numberOfLines:Int, alignment : NSTextAlignment)
    {
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.text = titleText
        label.textColor = textColor
        label.adjustsFontForContentSizeCategory = false
    }
    
    func dotlineStyle( color:UIColor) {
        DispatchQueue.main.async {
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = color.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
    
    func addBottomLayer(color: UIColor, space:CGFloat, lineHeight: CGFloat) {
        doOnMain {
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setNeedsLayout()
            self.layoutIfNeeded()
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height + space, width: self.frame.size.width, height: lineHeight)
            self.layer.addSublayer(border)
        }
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
