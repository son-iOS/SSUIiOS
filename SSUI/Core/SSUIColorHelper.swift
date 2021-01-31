//
//  SSUIColorHelper.swift
//  Okee
//
//  Created by Son Nguyen on 10/30/20.
//

import Foundation
import SwiftUI

class SSUIColorHelper {
    /// Split a string representation into a tuple of each distint color and alpla in RGB hex.
    /// - Parameter stringColor: The color stirng to split.
    /// - Returns: A tuple that contains each color and alpha represented by the string.
    private static func splitColorString(stringColor: String) -> (red: Double, green: Double, blue: Double, alpha: Double)? {
        guard let red = Double("0x\(stringColor[2...3])"),
              let green = Double("0x\(stringColor[4...5])"),
              let blue = Double("0x\(stringColor[6...7])"),
              let alpha = Double("0x\(stringColor[0...1])") else {
            return nil
        }
        
        return (red/0xFF, green/0xFF, blue/0xFF, alpha/0xFF)
    }
    
    /// Convert a string representation of a RGB color into Color.
    /// - Parameter stringColor: The string representation.
    /// - Returns: The converted Color.
    static func convertStringToColor(stringColor: String) -> Color? {
        guard stringColor.count == 8, let color = splitColorString(stringColor: stringColor) else {
            return nil
        }
        
        return Color(.sRGB, red: color.red, green: color.green, blue: color.blue, opacity: color.alpha)
    }
    
    static func convertStringsToGradient(_ strings: [String]?) -> LinearGradient? {
        guard let strings = strings, strings.count >= 3 else {
            return nil
        }
        
        guard let colors = strings[0..<strings.count - 1].map({ (color) -> Color? in
            convertStringToColor(stringColor: color)
        }) as? [Color] else {
            return nil
        }
        
        let gradient = Gradient(colors: colors)
        let isVertical = strings.last?.lowercased() == "v"
        let linearGradient = LinearGradient(gradient: gradient,
                                            startPoint: isVertical ? .top : .leading,
                                            endPoint: isVertical ? .bottom : .trailing)
        
        return linearGradient
    }
}

private extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

private extension String {
  subscript(value: NSRange) -> String {
    String(self[value.lowerBound..<value.upperBound])
  }
}

private extension String {
  subscript(value: CountableClosedRange<Int>) -> String {
    String(self[index(at: value.lowerBound)...index(at: value.upperBound)])
  }

  subscript(value: CountableRange<Int>) -> String {
    String(self[index(at: value.lowerBound)..<index(at: value.upperBound)])
  }

  subscript(value: PartialRangeUpTo<Int>) -> String {
    String(self[..<index(at: value.upperBound)])
  }

  subscript(value: PartialRangeThrough<Int>) -> String {
    String(self[...index(at: value.upperBound)])
  }

  subscript(value: PartialRangeFrom<Int>) -> String {
    String(self[index(at: value.lowerBound)...])
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}
