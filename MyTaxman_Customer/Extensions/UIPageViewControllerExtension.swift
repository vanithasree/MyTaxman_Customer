//
//  UIPageViewControllerExtension.swift
//  jps
//
//  Created by vijaykarthik on 16/05/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
    
    func goToNextPage() {
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        
        setViewControllers([nextViewController], direction: .forward, animated: true) { completed in  self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: completed) }
    }
    
    
    func goToPreviousPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
        
        //setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
        
        setViewControllers([previousViewController], direction: .reverse, animated: true) { completed in  self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: completed) }
        
    }
    
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
