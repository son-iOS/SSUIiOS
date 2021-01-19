//
//  SSUIPosition.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation

public enum SSUIPosition: String, Codable {
    case topLeft
    case top
    case topRight
    case middleRight
    case bottomRight
    case bottom
    case bottomLeft
    case middleLeft
    case middle
    
    public enum Vertical: String, Codable {
        case top
        case middle
        case bottom
    }
    
    public enum Horizontal: String, Codable {
        case right
        case middle
        case left
    }
}
