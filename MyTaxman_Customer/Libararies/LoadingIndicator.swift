//
//  LoadingIndicator.swift
//  SpellingBee
//
//  Created by Kathiresan on 01/02/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

/// Loading indicator
class LoadingIndicator: UIView {
    
    /// ActivityIndicator
    private let loader: NVActivityIndicatorView = {
        
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        activityIndicator.type = .ballClipRotateMultiple // add your type
        activityIndicator.color = ColorManager.darkTheme.color
        //        activityIndicator.backgroundColor = UIColor.init(white: 0.2, alpha: 1.0)
        //        activityIndicator.layer.cornerRadius = 4
        //        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        //        indicatorView.frame = .init(x: 0, y: 0, width: 60, height: 60)
        //        indicatorView.color = .white
        //        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        //        indicatorView.layer.cornerRadius = 10
        return  activityIndicator
    }()
    
    /// Shared Instance
    static let shared: LoadingIndicator = LoadingIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Design Indicator and Adding subView to Window
    func prepared() {
        tag = 101011
        self.addSubview(loader)
    }
    
    /// Show Indicator View with animation
    func show(forView: UIView, useAutoLayout: Bool = false) {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        if let previousLoader = forView.subviews.filter({$0.tag == 101011 }).first as? LoadingIndicator {
            previousLoader.hide()
        }
        
        self.frame = forView.frame
        loader.center = self.center
        
        forView.addSubview(self)
        
        //if useAutoLayout {
        //forView.translatesAutoresizingMaskIntoConstraints = false
        self.fillSuperview()
        loader.centerInSuperview()
        //        }
        
        loader.startAnimating()
        loader.bringSubviewToFront(forView)
    }
    
    /// Hide Indicator View with animation
    func hide() {
        self.removeFromSuperview()
        loader.stopAnimating()
    }
}
