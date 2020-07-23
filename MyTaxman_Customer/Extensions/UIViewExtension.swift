//
//  UIViewExtension.swift
//  jps
//
//  Created by Prem kumar on 20/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import UIKit
import SDWebImage

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    var cornerRadius: CGFloat{
        set{
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        doOnMain {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func applyViewPropertiesOnTextFieldBaseView() {
        
        // self.cornerRadius = 5
        self.backgroundColor = ColorManager.white.color
        self.layer.borderColor = ColorManager.borderColor.color.cgColor
        self.layer.borderWidth = 0.5
        
    }
    
    func createDottedLine(width: CGFloat, color: CGColor) {
        
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    
    /// Fill superview
    /// - Parameter padding: padding
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIImageView {
    
    // Extension to load image from url async.
    ///
    /// - Parameter urlString: URL String of image.
    /// - Parameter placeholderImages: placeholder images
    func load(from urlString: String?, orLocalImages: String = "welcomeAvatar") {
        
        
        let placeholder = UIImage(named: orLocalImages)
        /*
         if let placeholderImage = orLocalImages.count >= 1 ? placeholderImages.randomElement() : placeholderImages.first {
         placeholder = UIImage(named: placeholderImage)
         }
         */
        
        guard let imageUrl = URL(string: urlString ?? "") else {
            self.image = placeholder
            return
        }
        self.sd_setIndicatorStyle(.gray)
        self.sd_setShowActivityIndicatorView(true)
        sd_setImage(with: imageUrl,
                    placeholderImage: placeholder,
                    options: SDWebImageOptions.continueInBackground,
                    progress: { (pr1, pr2, url) in
                        //proceed
        }, completed: { (downloadedImage, error, cachType, url) in
            //proceed
            
            self.image = downloadedImage
        })
    }
}
