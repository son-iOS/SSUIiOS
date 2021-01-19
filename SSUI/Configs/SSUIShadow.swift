//
//  SSUIShadow.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUIShadow: Decodable {
    let x: CGFloat
    let y: CGFloat
    let radius: CGFloat
    let color: SSUIColor
    
    init(x: CGFloat, y: CGFloat, radius: CGFloat, color: SSUIColor) {
        self.x = x
        self.y = y
        self.radius = radius
        self.color = color
    }
    
    func elevatedTextField(multiplier: CGFloat, appliedToRadius: Bool = false) -> SSUIShadow {
        return SSUIShadow(x: self.x * multiplier, y: self.y * multiplier,
                          radius: self.radius * (appliedToRadius ? multiplier : 1), color: self.color)
    }
}

public extension View {
    func applySSUIShadow(_ shadow: SSUIShadow?) -> some View {
        guard let shadow = shadow else {
            return self.anyView
        }
        return self.shadow(color: shadow.color.color ?? .black, radius: shadow.radius, x: shadow.x, y: shadow.y).anyView
    }
}
