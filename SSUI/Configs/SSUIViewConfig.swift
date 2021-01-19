//
//  SSUIViewConfig.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUIViewConfig: Decodable {
    
    let backgroundColor: SSUIColor?
    let foregroundColor: SSUIColor?
    let corners: SSUICorners?
    let stroke: SSUILine?
    let shadow: SSUIShadow?
    let font: SSUIFont?
    let frame: SSUIFrame?
    
    public init(backgroundColor: SSUIColor? = nil, foregroundColor: SSUIColor? = nil,
                corners: SSUICorners? = nil, stroke: SSUILine? = nil,
                shadow: SSUIShadow? = nil, font: SSUIFont? = nil,
                frame: SSUIFrame? = nil) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.corners = corners
        self.stroke = stroke
        self.shadow = shadow
        self.font = font
        self.frame = frame
    }
    
    public static func circle(radius: CGFloat, backgroundColor: SSUIColor? = nil,
                              foregroundColor: SSUIColor? = nil, stroke: SSUILine? = nil,
                              shadow: SSUIShadow? = nil, font: SSUIFont? = nil) -> SSUIViewConfig {
        let corner = SSUICorners(topLeft: radius, topRight: radius, bottomRight: radius, bottomLeft: radius)
        let frame = SSUIFrame.fixedSize(width: radius * 2, height: radius * 2)
        return SSUIViewConfig(backgroundColor: backgroundColor, foregroundColor: foregroundColor,
                              corners: corner, stroke: stroke, shadow: shadow, font: font, frame: frame)
    }
    
    public static func fromJson(filename: String) -> SSUIViewConfig? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return SSUIViewConfig.fromData(data)
            } catch (let error) {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    public static func fromData(_ data: Data) -> SSUIViewConfig? {
        do {
            let config = try JSONDecoder().decode(SSUIViewConfig.self, from: data)
            return config
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
    internal var isEmpty: Bool {
        return backgroundColor == nil && foregroundColor == nil && corners == nil
            && stroke == nil && shadow == nil && font == nil && frame == nil
    }
}

public extension View {
    func applySSUIConfig(_ config: SSUIViewConfig?) -> some View {
        guard let config = config, !config.isEmpty else {
            return self.anyView
        }
        let corners = config.corners
        let shape = SSUIIndependentRoundedRectangle(topLeft: corners?.topLeft ?? 0,
                                                    topRight: corners?.topRight ?? 0,
                                                    bottomLeft: corners?.bottomRight ?? 0,
                                                    bottomRight: corners?.bottomLeft ?? 0)
        
        var view = self.applySSUIFrame(config.frame)
        if let gradient = config.backgroundColor?.gradient {
            view = view.background(shape.fill(gradient)).anyView
            
        } else if let color = config.backgroundColor?.color {
            view = view.background(shape.fill(color)).anyView
        }
        return view
            .cornerRadius(config.corners?.areCornersTheSame ?? false ? config.corners?.topLeft ?? 0 : 0)
            .overlay(shape.strokeBorder(usingLine: config.stroke))
            .foregroundColor(config.foregroundColor?.color)
            .applySSUIFont(config.font)
            .applySSUIShadow(config.shadow)
            .anyView
    }
    
    func applyConfigsForStates<H: Hashable>(stateBinding: Binding<H>, _ configs: [H: SSUIViewConfig]) -> some View{
        let config = configs[stateBinding.wrappedValue]
        return self.applySSUIConfig(config)
    }
}
