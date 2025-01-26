//
//  Item.swift
//  icongenerator
//
//  Created by admin on 27.1.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
