//
//  SSUILine.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUILine: Decodable {
    
    public enum LineStyle: String, Decodable {
        case rounded
        case butt
        case square
        
        var capStyle: CGLineCap {
            switch self {
            case .rounded:
                return .round
            case .butt:
                return .butt
            case .square:
                return .square
            }
        }
        
        var joinStyle: CGLineJoin {
            switch self {
            case .rounded:
                return .round
            case .butt, .square:
                return .miter
            }
        }
    }
    
    let width: CGFloat
    let color: SSUIColor
    let isInnerStroke: Bool
    let lineStyle: LineStyle
    
    
    public init(width: CGFloat, color: SSUIColor, isInnerStroke: Bool = true, lineStyle: SSUILine.LineStyle = .square) {
        self.width = width
        self.color = color
        self.isInnerStroke = isInnerStroke
        self.lineStyle = lineStyle
    }
}

public extension InsettableShape {
    func strokeBorder(usingLine line: SSUILine?) -> some View {
        if line?.isInnerStroke ?? true {
            return self.strokeBorder(line?.color.color ?? .clear,
                                     style: StrokeStyle(lineWidth: line?.width ?? 0,
                                                        lineCap: line?.lineStyle.capStyle ?? .square,
                                                        lineJoin: line?.lineStyle.joinStyle ?? .miter))
                .anyView
        } else {
            return self.stroke(usingLine: line).anyView
        }
    }
    
    func stroke(usingLine line: SSUILine?) -> some View {
        return self.stroke(line?.color.color ?? .clear, lineWidth: line?.width ?? 0)
    }
}
