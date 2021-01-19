//
//  SSUICross.swift
//  Okee
//
//  Created by Son Nguyen on 1/4/21.
//

import Foundation
import SwiftUI

public struct SSUICross: InsettableShape {
    
    private var insetAmount: CGFloat = 0
    
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        Path { path in

            let w = rect.size.width
            let h = rect.size.height

            path.move(to: CGPoint(x: 0 + insetAmount, y: insetAmount))
            path.addLine(to: CGPoint(x: w - insetAmount, y: h - insetAmount))
            path.move(to: CGPoint(x: w - insetAmount, y: insetAmount))
            path.addLine(to: CGPoint(x: insetAmount, y: h - insetAmount))
        }
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }
}
