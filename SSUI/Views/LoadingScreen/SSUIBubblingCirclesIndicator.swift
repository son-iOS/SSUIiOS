//
//  SSUIRippleCirclesIndicator.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

/// A custom loading indicator that has 3 circles scaling up and down.
public struct SSUIBubblingCirclesIndicator: View {
    
    @State private var shouldAnimate = false
    
    let diameter: CGFloat
    let color: SSUIColor
        
    public var body: some View {
        HStack {
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            }
            Spacer()
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            }
            Spacer()
            if let gradient = color.gradient {
                Circle()
                    .fill(gradient)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
            } else {
                Circle()
                    .fill(color.color ?? .black)
                    .frame(width: diameter, height: diameter)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
            }
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}
