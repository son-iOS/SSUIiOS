//
//  SSUIFormConfig.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUIFormConfig: Decodable {
    
    let coverColor: SSUIColor?
    let backgroundColor: SSUIColor?
    let corners: SSUICorners?
    let stroke: SSUILine?
    let shadow: SSUIShadow?
    let frame: SSUIFrame?
    let isFullscreen: Bool
    let animationDuration: TimeInterval
    public let contentPosition: SSUIPosition.Vertical
    
    public init(coverColor: SSUIColor? = nil, backgroundColor: SSUIColor? = nil,
                corners: SSUICorners? = nil, stroke: SSUILine? = nil, shadow: SSUIShadow? = nil,
                frame: SSUIFrame? = nil, isFullScreen: Bool = false, animationDuration: TimeInterval,
                contentPosition: SSUIPosition.Vertical = .middle) {
        self.coverColor = coverColor
        self.backgroundColor = backgroundColor
        self.corners = corners
        self.stroke = stroke
        self.shadow = shadow
        self.frame = frame
        self.isFullscreen = isFullScreen
        self.animationDuration = animationDuration
        self.contentPosition = contentPosition
    }
    
}

public extension View {
    func form(isPresented: Binding<Bool>, configs: [AnyHashable: SSUIFormConfig?], form: SSUIForm?) -> some View {
        guard let form = form, let config = configs[form.type] else {
            return SSUICoverView(isPresented: isPresented, rootView: self, position: .middle,
                                 backgroundColor: SSUIColor.color(light: .white),
                                 animationDuration: 0){
                EmptyView().anyView
            }.anyView
        }
        if config?.isFullscreen ?? false, #available(iOS 14.0, *) {
            return self.fullScreenCover(isPresented: isPresented, content: {
                form.getContent(usingConfig: config)
            }).anyView
        } else {
            return SSUICoverView(isPresented: isPresented, rootView: self, position: config?.contentPosition ?? .middle,
                                 backgroundColor: config?.coverColor ?? SSUIColor.color(light: .white),
                                 animationDuration: config?.animationDuration ?? 0){
                form.getContent(usingConfig: config).anyView
            }.anyView
        }
    }
}
