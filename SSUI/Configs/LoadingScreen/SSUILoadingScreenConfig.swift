//
//  SSUILoadingScreenConfig.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUILoadingScreenConfig: Decodable {
    public enum LoadingIndicatorStyle: String, Decodable {
        case system
        case bubblingCircles
        case sidewayCircles
        case custom
    }
    
    let backgroundColor: SSUIColor
    let color: SSUIColor
    let frame: SSUIFrame
    let style: LoadingIndicatorStyle
    
    public init(backgroundColor: SSUIColor, color: SSUIColor, frame: SSUIFrame, style: SSUILoadingScreenConfig.LoadingIndicatorStyle) {
        self.backgroundColor = backgroundColor
        self.color = color
        self.frame = frame
        self.style = style
    }
}

public extension View {
    func loading(isPresented: Binding<Bool>, customView: AnyView? = nil, config: SSUILoadingScreenConfig?) -> some View {
        let indicator = getIndicator(config: config)
        return SSUICoverView(isPresented: isPresented, rootView: self,
                             position: .middle, backgroundColor: config?.backgroundColor ?? SSUIColor.color(light: .white),
                             animationDuration: 0) {
            VStack {
                customView
                indicator
            }.anyView
        }
    }
    
    private func getIndicator(config: SSUILoadingScreenConfig?) -> some View {
        guard let config = config else {
            return SSUISystemIndicator().anyView
        }
        switch config.style {
        case .bubblingCircles:
            return SSUIBubblingCirclesIndicator(diameter: config.frame.height ??
                                                    config.frame.width ?? 1,
                                                color: config.color).anyView
        case .system:
            return SSUISystemIndicator().anyView
        case .sidewayCircles:
            return SSUISidewayCirclesIndicator(offset: config.frame.width ?? 2,
                                               diameter: config.frame.height ?? 1,
                                               color: config.color).anyView
        case .custom:
            return SSUI.shared.customizer?.customLoadingIndicator?.anyView ?? EmptyView().anyView
        }
    }
}

public struct SSUISystemIndicator: UIViewRepresentable {
    
    public init() {}
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        // nothing to do here
    }
    
    public func makeUIView(context: Context) -> some UIView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }
}
