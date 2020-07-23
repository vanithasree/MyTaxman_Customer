//
//  SliderExtension.swift
//  jps
//
//  Created by Prem kumar on 07/07/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import UIKit
class JPSSlider: UISlider {
    
    var thumbTextLabel: UILabel = UILabel()
    
    private var toolTip: ToolTipPopupView?
    
    @IBInspectable var trackHeight: CGFloat = 2
    
    var isHideTooltip: Bool = true
    
    var toolTipInfo : String = ""

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbTextLabel.frame = thumbFrame
        thumbTextLabel.cornerRadius = thumbFrame.width / 2
        thumbTextLabel.text = "\(Int(value))\n\(thumbTextLabel.accessibilityHint ?? "")" //.roundTo(places: 1).description
        
        let dateAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: thumbTextLabel.text ?? "")
        dateAttributedString.setColorForText(textForAttribute: "\(thumbTextLabel.accessibilityHint ?? "")", withColor: ColorManager.white.color, withFont: UIFont(name:Font.FontName.PoppinsRegular.rawValue, size: 8)!)
        //        dateAttributedString.setLineSpaceForText(lineSpace: 2, alignment: thumbTextLabel.textAlignment)
        thumbTextLabel.attributedText = dateAttributedString
        
//        let tRect = thumbRect
        if isHideTooltip {
            toolTip?.frame = .zero
            toolTip?.text = ""
        }else {
            let popupRect = thumbFrame.offsetBy(dx: 0, dy: -(thumbFrame.size.height * 1.5))
            toolTip?.frame = popupRect.insetBy(dx: -20, dy: -10)
            toolTip?.text = toolTipInfo
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.text = ""
        thumbTextLabel.numberOfLines = 0
        thumbTextLabel.adjustsFontSizeToFitWidth = true
        thumbTextLabel.textColor = ColorManager.white.color
        thumbTextLabel.backgroundColor = ColorManager.darkTheme.color
        thumbTextLabel.font = UIFont(name:Font.FontName.PoppinsBold.rawValue, size: Utility.dynamicSize(12.0))
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        
        self.initToolTip()
    }
    
    private func initToolTip() {
        toolTip = ToolTipPopupView.init(frame: CGRect.zero)
        toolTip?.backgroundColor = .clear
        toolTip?.fillColor = ColorManager.darkTheme.color
        toolTip?.textColor = ColorManager.white.color
        toolTip?.draw(.zero)
        toolTip?.font = UIFont(name:Font.FontName.PoppinsSemiBold.rawValue, size: Utility.dynamicSize(12.0))!
        self.addSubview(toolTip!)
    }
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        
        let knobRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let popupRect = knobRect.offsetBy(dx: 0, dy: -(knobRect.size.height))
        toolTip?.frame = popupRect.offsetBy(dx: 0, dy: 0)
        return knobRect
    }
}

class ToolTipPopupView: UIView {

    // MARK: properties
    var font: UIFont = UIFont.boldSystemFont(ofSize: 18.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var value: String {
        get {
            if let text = text {
                return text
            }
            return ""
        }
        set {
            text = newValue
        }
    }
    
    var fillColor = UIColor(white: 0, alpha: 0.8) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var textColor = UIColor(white: 1.0, alpha: 0.8) {
        didSet {
            setNeedsDisplay()
        }
    }
        
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        fillColor.setFill()
        
        let roundedRect = CGRect(x:bounds.origin.x, y:bounds.origin.y, width:bounds.size.width, height:bounds.size.height * 0.8)
        let roundedRectPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: 6.0)
        
        // create arrow
        let arrowPath = UIBezierPath()
        
        let p0 = CGPoint(x: bounds.midX, y: bounds.maxY - 2.0 )
        arrowPath.move(to: p0)
        arrowPath.addLine(to: CGPoint(x:bounds.midX - 6.0, y: roundedRect.maxY))
        arrowPath.addLine(to: CGPoint(x:bounds.midX + 6.0, y: roundedRect.maxY))
        
        roundedRectPath.append(arrowPath)
        roundedRectPath.fill()
        
        // draw text
        if let text = self.text {
            
            let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
            let yOffset = (roundedRect.size.height - size.height) / 2.0
            let textRect = CGRect(x:roundedRect.origin.x, y: yOffset, width: roundedRect.size.width, height: size.height)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: textColor]
            text.draw(in:textRect, withAttributes: attrs)
        }
    }

}
