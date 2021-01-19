//
//  SSUIPageSlideConfig.swift
//  Okee
//
//  Created by Son Nguyen on 1/14/21.
//

import Foundation

public struct SSUIPageSlideConfig: Decodable {
    let config: SSUIViewConfig
    let indicator: IndicatorConfig
    
    public init(config: SSUIViewConfig, indicator: SSUIPageSlideConfig.IndicatorConfig) {
        self.config = config
        self.indicator = indicator
    }
    
    public struct IndicatorConfig: Decodable {
        public enum Style: String, Decodable {
            case none
            case system
            case slidingBar
        }
        
        let style: Style
        let config: SSUIViewConfig
        
        public init(style: SSUIPageSlideConfig.IndicatorConfig.Style, config: SSUIViewConfig) {
            self.style = style
            self.config = config
        }
    }
}
