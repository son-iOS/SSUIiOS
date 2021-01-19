//
//  SSUIDirection.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation

public enum SSUIDirection: String, Decodable {
    case upward
    case downward
    case rightward
    case leftward
    
    public enum General: String, Decodable {
        case vertical
        case horizontal
    }
}
