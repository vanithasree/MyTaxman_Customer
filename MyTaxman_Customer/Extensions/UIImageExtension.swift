//
//  UIImageExtension.swift
//  jps
//
//  Created by Prem kumar on 13/06/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        //        let maskImage = cgImage!
        //
        //        let width = size.width
        //        let height = size.height
        //        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        //
        //        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        //        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        //
        //        context.clip(to: bounds, mask: maskImage)
        //        context.setFillColor(color.cgColor)
        //        context.fill(bounds)
        //
        //        if let cgImage = context.makeImage() {
        //            let coloredImage = UIImage(cgImage: cgImage)
        //            return coloredImage
        //        } else {
        //            return nil
        //        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
