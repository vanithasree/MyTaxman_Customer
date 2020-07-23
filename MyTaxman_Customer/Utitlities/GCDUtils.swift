//
//  GCDUtils.swift
//  jps
//
//  Created by Prem kumar on 27/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
func doInBackground(_ block: @escaping () -> ()) {
    DispatchQueue.global(qos: .default).async {
        block()
    }
}

func doOnMain(_ block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
