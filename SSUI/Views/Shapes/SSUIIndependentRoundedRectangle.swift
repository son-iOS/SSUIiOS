//
//  SSUIIndependentRoundedRectangle.swift
//  Okee
//
//  Created by Son Nguyen on 12/30/20.
//

import Foundation
import SwiftUI

public struct SSUIIndependentRoundedRectangle: InsettableShape {
    
    private let topLeft: CGFloat
    private let topRight: CGFloat
    private let bottomLeft: CGFloat
    private let bottomRight: CGFloat
    
    private var insetAmount: CGFloat = 0
    
    public init(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        self.insetAmount = 0
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in

            let w = rect.size.width
            let h = rect.size.height

            // Make sure we do not exceed the size of the rectangle
            let tr = min(min(self.topRight, h/2), w/2)
            let tl = min(min(self.topLeft, h/2), w/2)
            let bl = min(min(self.bottomLeft, h/2), w/2)
            let br = min(min(self.bottomRight, h/2), w/2)
            
            let insetAmount = min(tr != 0 ? tr : self.insetAmount,
                                  tl != 0 ? tl : self.insetAmount,
                                  bl != 0 ? bl : self.insetAmount,
                                  br != 0 ? br : self.insetAmount,
                                  self.insetAmount)

            path.move(to: CGPoint(x: w / 2.0, y: insetAmount))
            path.addLine(to: CGPoint(x: w - tr, y: insetAmount))
            path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr - insetAmount, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: w - insetAmount, y: h - br - insetAmount))
            path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br - insetAmount, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: bl, y: h - insetAmount))
            path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl - insetAmount, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: insetAmount, y: tl))
            path.addArc(center: CGPoint(x: tl, y: tl), radius: tl - insetAmount, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            path.closeSubpath()
        }
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }
}
