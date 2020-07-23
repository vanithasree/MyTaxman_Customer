//
//  UITextFieldExtension.swift
//  jps
//
//  Created by vijaykarthik on 29/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit
import TweeTextField

extension TweeAttributedTextField {
    func setTextFieldProperties(placeholderString: String, isSecureText:Bool, isMobileField: Bool = false, isFieldRequired:Bool = false) {
        self.isSecureTextEntry = isSecureText
        self.textColor = ColorManager.darkText.color
        self.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0))
        
        self.isSecureTextEntry = isSecureText
        self.infoTextColor = UIColor.red //Color.theme.value
        self.textColor = ColorManager.darkText.color
        
        let userFont = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote)
        //        let pointSize = 13.0
        self.infoFontSize = 10
        self.minimumPlaceholderFontSize = 13.0
        self.originalPlaceholderFontSize = 13.0
        
        self.infoLabel.font = UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(13.0))
        //        textField.tweePlaceholder = placeholderString
       // self.placeholderColor = .clear
        //        textField.placeholderLabel.backgroundColor = .cyan
        //textField.lineColor = Color.lightText.value
        self.font =  UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: Utility.dynamicSize(17.0))
        // textField.attributedPlaceholder =
        
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.red])
        
        let passwordAttriburedString = NSMutableAttributedString(string: placeholderString, attributes: [NSAttributedString.Key.foregroundColor: ColorManager.lightText.color, NSAttributedString.Key.font :self.infoLabel.font ?? userFont])
        
        //  textField.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [NSAttributedString.Key.foregroundColor: ColorManager.lightText.color, NSAttributedString.Key.font :textField.infoLabel.font ?? userFont])
        
        self.backgroundColor = .clear
        
        self.activeLineColor = .systemBlue
        self.activeLineWidth = 1
        self.animationDuration = 0.3
                
        self.borderStyle = .none
    
        self.lineColor = .lightGray
        self.lineWidth = 1
        
        if isFieldRequired {
            passwordAttriburedString.append(asterix)
        }
        self.attributedTweePlaceholder = passwordAttriburedString
    }
}

extension UITextField {
    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPadding(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setRightPaddingImage(_ amount:CGFloat , image : UIImage, color: UIColor) {
        let gamount = self.frame.size.height / 2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: gamount + 10, height: self.frame.size.height))
        let imgView = UIImageView(frame: CGRect(x: 5, y: (paddingView.frame.size.height/2) - 7.5, width: 15, height: 15))
        imgView.image = image.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = color
        imgView.contentMode = .scaleAspectFit
        paddingView.addSubview(imgView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        paddingView.isUserInteractionEnabled = true
        paddingView.addGestureRecognizer(tap)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.becomeFirstResponder()
    }
}
