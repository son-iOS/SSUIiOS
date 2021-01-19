//
//  SSUITabViewConfig.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation

public struct SSUITabViewConfig: Decodable {
    
    public enum SelectionEffect: String, Decodable {
        case none
        case scale
    }
    
    let backgroundColor: SSUIColor?
    let corner: SSUICorners?
    let stroke: SSUILine?
    let shadow: SSUIShadow?
    let selectionEffect: SelectionEffect?
    let fullWidth: Bool?
    let contentBackground: SSUIColor?
    
    
    public init(backgroundColor: SSUIColor? = nil, corner: SSUICorners? = nil,
                stroke: SSUILine? = nil, shadow: SSUIShadow? = nil,
                selectionEffect: SSUITabViewConfig.SelectionEffect? = nil,
                fullWidth: Bool? = nil, contentBackground: SSUIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.corner = corner
        self.stroke = stroke
        self.shadow = shadow
        self.selectionEffect = selectionEffect
        self.fullWidth = fullWidth
        self.contentBackground = contentBackground
    }
}
