//
//  SSUIAlertConfig.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUIAlertConfig: Decodable {
    
    let coverColor: SSUIColor?
    let backgroundColor: SSUIColor?
    let corners: SSUICorners?
    let stroke: SSUILine?
    let shadow: SSUIShadow?
    let frame: SSUIFrame?
    let isFullScreen: Bool
    let contentPosition: SSUIPosition.Vertical
    let actionsPosition: SSUIPosition.Vertical
    let actionsStackDirection: SSUIDirection.General
    let animationDuration: TimeInterval
    
    public init(coverColor: SSUIColor? = nil, backgroundColor: SSUIColor? = nil,
                corners: SSUICorners? = nil, stroke: SSUILine? = nil,
                shadow: SSUIShadow? = nil, frame: SSUIFrame? = nil,
                isFullScreen: Bool = false, contentPosition: SSUIPosition.Vertical = .middle,
                actionsPosition: SSUIPosition.Vertical = .bottom,
                actionsStackDirection: SSUIDirection.General = .vertical,
                animationDuration: TimeInterval = 0) {
        self.coverColor = coverColor
        self.backgroundColor = backgroundColor
        self.corners = corners
        self.stroke = stroke
        self.shadow = shadow
        self.frame = frame
        self.isFullScreen = isFullScreen
        self.contentPosition = contentPosition
        self.actionsPosition = actionsPosition
        self.actionsStackDirection = actionsStackDirection
        self.animationDuration = animationDuration
    }
}

public extension View {
    func alert(isPresented: Binding<Bool>, configs: [AnyHashable: SSUIAlertConfig?], alert: SSUIAlert?) -> some View {
        guard let alert = alert, let config = configs[alert.type] else {
            return SSUICoverView(isPresented: isPresented, rootView: self, position: .middle,
                                 backgroundColor: SSUIColor.color(light: .white),
                                 animationDuration: 0){
                EmptyView().anyView
            }.anyView
        }
        if config?.isFullScreen ?? false {
            return self.fullScreenCover(isPresented: isPresented, content: {
                alert.getFullscreenContent(usingConfig: config).edgesIgnoringSafeArea(.all)
            }).anyView
        } else {
            return SSUICoverView(isPresented: isPresented, rootView: self, position: config?.contentPosition ?? .middle ,
                                 backgroundColor: config?.coverColor ?? SSUIColor.color(light: .white),
                                 animationDuration: config?.animationDuration ?? 0) {
                alert.getNonFullscreenContent(usingConfig: config).anyView
            }
                .anyView
        }
    }
}
