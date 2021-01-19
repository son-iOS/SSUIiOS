//
//  SSUIPageIndicator.swift
//  Okee
//
//  Created by Son Nguyen on 1/14/21.
//

import Foundation
import SwiftUI

public struct SSUIPageIndicator: View {
    @Binding var selection: Int
    let style: SSUIPageSlideConfig.IndicatorConfig.Style
    let count: Int
    let config: SSUIViewConfig
    
    public var body: some View {
        switch style {
        case .system, .none:
            return EmptyView().anyView
        case .slidingBar:
            return slidingBar.anyView
        }
    }
    
    private var slidingBar: some View {
        let width = config.frame?.width ?? UIScreen.main.bounds.width
        let barWidth = width / CGFloat(count)
        let height = config.frame?.height ?? 10
        let offset = -width/2 + barWidth/2 + barWidth*CGFloat(selection)
        
        return ZStack {
            Capsule(style: .circular)
                .frame(width: width, height: height)
                .applySSUIConfig(config)
                .opacity(0.3)
            Capsule(style: .circular)
                .frame(width: barWidth, height: height)
                .offset(x: offset)
                .applySSUIConfig(config)
                .animation(.linear)
        }
    }
}
