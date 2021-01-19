//
//  SSUIColor.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUIColor: Decodable {
       
    private let light: Color?
    private let dark: Color?
    private let lightGradient: LinearGradient?
    private let darkGradient: LinearGradient?
    
    /// Coverted color from the raw string
    public var color: Color? {
        UITraitCollection.current.userInterfaceStyle == .dark ? dark : light
    }
    
    /// Converted linear gradient from an array of raw strings.
    public var gradient: LinearGradient? {
        return UITraitCollection.current.userInterfaceStyle == .dark ? darkGradient : lightGradient
    }
    
    /// Create a view based on the specified gradient and color.
    public var colorAsView: AnyView {
        if let gradient = gradient {
            return gradient.anyView
        } else {
            return color.anyView
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case light
        case dark
        case lightGradient
        case darkGradient
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            let lightString = try values.decode(String.self, forKey: .light)
            light = SSUIColorHelper.convertStringToColor(stringColor: lightString)
        } catch {
            light = nil
        }
        
        do {
            let darkString = try values.decode(String.self, forKey: .dark)
            dark = SSUIColorHelper.convertStringToColor(stringColor: darkString)
        } catch {
            dark = light
        }
        
        do {
            let lightArrays = try values.decode(Array<String>.self, forKey: .lightGradient)
            lightGradient = SSUIColorHelper.convertStringsToGradient(lightArrays)
        } catch {
            lightGradient = nil
        }
        
        do {
            let darkArrays = try values.decode(Array<String>.self, forKey: .darkGradient)
            darkGradient = SSUIColorHelper.convertStringsToGradient(darkArrays)
        } catch {
            darkGradient = lightGradient
        }
    }
    
    private init(light: Color? = nil, dark: Color? = nil, lightGradient: LinearGradient? = nil, darkGradient: LinearGradient? = nil) {
        self.light = light
        self.dark = dark
        self.lightGradient = lightGradient
        self.darkGradient = darkGradient
    }
    
    private init(light: String? = nil, dark: String? = nil, lightGradient: [String]? = nil, darkGradient: [String]? = nil) {
        self.light = Color.fromString(light)
        self.dark = Color.fromString(dark)
        self.lightGradient = LinearGradient.fromStrings(lightGradient)
        self.darkGradient = LinearGradient.fromStrings(darkGradient)
    }
    
    public static func color(light: Color? = nil, dark: Color? = nil) -> SSUIColor {
        return SSUIColor(light: light, dark: dark)
    }
    
    public static func color(light: String? = nil, dark: String? = nil) -> SSUIColor {
        return SSUIColor(light: light, dark: dark)
    }
    
    public static func gradient(light: LinearGradient? = nil, dark: LinearGradient? = nil) -> SSUIColor {
        return SSUIColor(lightGradient: light, darkGradient: dark)
    }
    
    public static func gradient(light: [String]? = nil, dark: [String]? = nil) -> SSUIColor {
        return SSUIColor(lightGradient: light, darkGradient: dark)
    }
}

public extension View {
    func applySSUIColorBackground(_ color: SSUIColor?) -> some View {
        guard let color = color else {
            return self.anyView
        }
        
        return self.background(color.colorAsView).anyView
    }
    
    func applySSUIColorForeground(_ color: SSUIColor?) -> some View {
        guard let color = color?.color else {
            return self.anyView
        }
        
        return self.foregroundColor(color).anyView
    }
}

public extension Color {
    static func fromString(_ string: String?) -> Color? {
        guard let string = string else {
            return nil
        }
        return SSUIColorHelper.convertStringToColor(stringColor: string)
    }
}

public extension LinearGradient {
    static func fromStrings(_ strings: [String]?) -> LinearGradient? {
        return SSUIColorHelper.convertStringsToGradient(strings) ?? nil
    }
}
