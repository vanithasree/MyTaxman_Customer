//
//  ArrayExtension.swift
//  jps
//
//  Created by Prem kumar on 18/06/20.
//  Copyright © 2020 vijaykarthik. All rights reserved.
//

import Foundation
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
