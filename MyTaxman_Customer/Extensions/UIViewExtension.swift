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
    
    /// Add shadow
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.masksToBounds = false
    }
    func setCardView() {
        /* layer.cornerRadius = 5.0
         layer.borderColor  =  ColorManager.lightGrey.color.cgColor
         layer.borderWidth = 1.0
         layer.shadowOpacity = 0.5
         layer.shadowColor =  UIColor.lightGray.cgColor
         layer.shadowRadius = 5.0
         layer.shadowOffset = CGSize(width:2, height: 2)
         layer.masksToBounds = true*/
        
        
        
        self.backgroundColor = .white
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        
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
    
    /* func makeGradientLayer(`for` object : UIView, startPoint : CGPoint, endPoint : CGPoint, gradientColors : [Any]) -> CAGradientLayer {
     let gradient: CAGradientLayer = CAGradientLayer()
     gradient.colors = gradientColors
     gradient.locations = [0.0 , 1.0]
     gradient.startPoint = startPoint
     gradient.endPoint = endPoint
     gradient.frame = CGRect(x: 0, y: 0, width: object.frame.size.width, height: object.frame.size.height)
     return gradient
     }*/
    
    
}

extension UIImageView {
    
    // Extension to load image from url async.
    ///
    /// - Parameter urlString: URL String of image.
    /// - Parameter placeholderImages: placeholder images
    func load(from urlString: String?, orLocalImages: String = "profile") {
        
        
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


class AnimationUtility: UIViewController, CAAnimationDelegate {
    
    static let kSlideAnimationDuration: CFTimeInterval = 0.4
    
    static func viewSlideInFromRight(toLeft views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromRight
        //        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
    
    static func viewSlideInFromLeft(toRight views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromLeft
        //        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
    
    static func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromBottom
        //        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
    
    static func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromTop
        //        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
}



private typealias SubviewTreeModifier = (() -> UIView)

public struct AppearanceOptions: OptionSet {
    
    public static let overlay = AppearanceOptions(rawValue: 1 << 0)
    public static let useAutoresize = AppearanceOptions(rawValue: 1 << 1)
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
}

extension UIView {
    
    fileprivate func addSubviewUsingOptions(_ options: AppearanceOptions, modifier: SubviewTreeModifier) {
        let subview = modifier()
        if options.union(.overlay) == .overlay {
            if options.union(.useAutoresize) != .useAutoresize {
                subview.translatesAutoresizingMaskIntoConstraints = false
                
                if #available(iOS 11.0, *) {
                    subview.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
                    subview.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
                    subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
                    subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
                } else {
                    let views = dictionaryOfNames([subview])
                    
                    let horisontalConstraints = NSLayoutConstraint.constraints(
                        withVisualFormat: "|[subview]|",
                        options: [],
                        metrics: nil,
                        views: views
                    )
                    addConstraints(horisontalConstraints)
                    
                    let verticalConstraints = NSLayoutConstraint.constraints(
                        withVisualFormat: "V:|[subview]|",
                        options: [],
                        metrics: nil,
                        views: views
                    )
                    addConstraints(verticalConstraints)
                }
            } else {
                frame = bounds
                subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
        }
    }
    
    fileprivate func dictionaryOfNames(_ views: [UIView]) -> [String: UIView] {
        var container = [String: UIView]()
        for (_, value) in views.enumerated() {
            container["subview"] = value
        }
        return container
    }
    
    // MARK: - Interface methods
    
    public func addSubview(_ subview: UIView, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        addSubviewUsingOptions(options) { [weak self] in
            self?.addSubview(subview)
            return subview
        }
    }
    
    public func insertSubview(_ subview: UIView, index: Int, options: AppearanceOptions) {
        if subview.superview == self {
            return
        }
        addSubviewUsingOptions(options) { [weak self] in
            self?.insertSubview(subview, at: index)
            return subview
        }
    }
    
}

extension Bundle {

    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }

    var bundleId: String {
        return bundleIdentifier!
    }

    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }

}
