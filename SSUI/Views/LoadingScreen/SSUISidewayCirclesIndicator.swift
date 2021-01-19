//
//  SSUISidewayCirclesIndicator.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

/// A custom loading indicator that slides 3 circle back and forth.
public struct SSUISidewayCirclesIndicator: View {
    @State private var shouldAnimate = false
    
    let offset: CGFloat
    var diameter: CGFloat
    var color: SSUIColor

    public init(offset: CGFloat, diameter: CGFloat, color: SSUIColor) {
        self.offset = offset
        self.diameter = diameter
        self.color = color
    }
    
    public var body: some View {
        return ZStack {
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            }
            
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.2))
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.2))
            }
            
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.4))
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .offset(x: shouldAnimate ? offset : -offset)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.4))
            }
        }.onAppear {
            shouldAnimate = true
        }
    }
}
