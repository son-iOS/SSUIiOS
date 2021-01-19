//
//  SSUIFont.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUIFont: Decodable {
    
    public enum Property: String, Codable {
        case bold
        case italic
        case smallCaps
        case lowercaseSmallCaps
        case uppercaseSmallCaps
        case monospacedDigit
        
        func apply(toFont font: Font) -> Font {
            switch self {
            case .bold:
                return font.bold()
            case .italic:
                return font.italic()
            case .smallCaps:
                return font.smallCaps()
            case .lowercaseSmallCaps:
                return font.lowercaseSmallCaps()
            case .uppercaseSmallCaps:
                return font.uppercaseSmallCaps()
            case .monospacedDigit:
                return font.monospacedDigit()
            }
        }
    }
    
    public enum Weight: String, Codable {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
        
        func applyWeight(toFont font: Font) -> Font {
            return font.weight(self.weight)
        }
        
        private var weight: Font.Weight {
            switch self {
            case .ultraLight:
                return .ultraLight
            case .thin:
                return .thin
            case .light:
                return .light
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .semibold:
                return .semibold
            case .bold:
                return .bold
            case .heavy:
                return .heavy
            case .black:
                return .black
            }
        }
    }
    
    public enum Alignment: String, Codable {
        case leading
        case center
        case trailing
        
        var alignment: TextAlignment {
            switch self {
            case .leading:
                return .leading
            case .center:
                return .center
            case .trailing:
                return .trailing
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case size
        case properties
        case weight
        case alignment
        case lineLimit
    }
    
    let name: String?
    var systemFont: Font? = nil
    let size: CGFloat?
    let properties: [Property]?
    let weight: Weight?
    let alignment: Alignment?
    let lineLimit: Int?
    
    public init(name: String, size: CGFloat? = nil, properties: [SSUIFont.Property]? = nil, weight: SSUIFont.Weight? = nil, alignment: Alignment? = nil, lineLimit: Int? = nil) {
        self.name = name
        self.size = size
        self.properties = properties
        self.weight = weight
        self.alignment = alignment
        self.lineLimit = lineLimit
    }
    
    public init(systemFont font: Font, size: CGFloat? = nil, properties: [SSUIFont.Property]? = nil, weight: SSUIFont.Weight? = nil, alignment: Alignment? = nil, lineLimit: Int? = nil) {
        self.systemFont = font
        self.size = size
        self.properties = properties
        self.weight = weight
        self.name = nil
        self.alignment = alignment
        self.lineLimit = lineLimit
    }
    
    public var font: Font {
        var font: Font
        if let systemFont = systemFont {
            font = systemFont
        } else if name == "system" {
            font = .system(size: size ?? 1)
        } else {
            font = Font.custom(name ?? "", size: size ?? 1)
        }
        properties?.forEach({ (property) in
            font = property.apply(toFont: font)
        })
        if let weight = weight {
            font = weight.applyWeight(toFont: font)
        }
        return font
    }
}

public extension View {
    func applySSUIFont(_ font: SSUIFont?) -> some View {
        guard let font = font else {
            return self.anyView
        }
        var view = self.anyView
        if let alignment = font.alignment {
            view = view.multilineTextAlignment(alignment.alignment).anyView
        }
        if let lineLimit = font.lineLimit {
            view = view.lineLimit(lineLimit).anyView
        }
        return view.font(font.font).anyView
    }
}
