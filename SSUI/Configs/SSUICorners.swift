//
//  SSUICorner.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUICorners: Codable {
    
    let topLeft: CGFloat?
    let topRight: CGFloat?
    let bottomRight: CGFloat?
    let bottomLeft: CGFloat?
    
    public init(topLeft: CGFloat? = nil, topRight: CGFloat? = nil, bottomRight: CGFloat? = nil, bottomLeft: CGFloat? = nil) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
    }
    
    public init(all: CGFloat?) {
        self.topLeft = all
        self.topRight = all
        self.bottomRight = all
        self.bottomLeft = all
    }
    
    var areCornersTheSame: Bool {
        topLeft == topRight && topRight == bottomRight && bottomRight == bottomLeft
    }
}
