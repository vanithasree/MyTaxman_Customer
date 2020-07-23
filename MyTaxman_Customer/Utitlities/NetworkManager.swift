//
//  NetworkManager.swift
//  jps
//
//  Created by vijaykarthik on 15/04/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

