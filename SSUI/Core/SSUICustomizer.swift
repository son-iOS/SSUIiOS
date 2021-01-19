//
//  SSUICustomViewCreator.swift
//  Okee
//
//  Created by Son Nguyen on 10/30/20.
//

import Foundation
import SwiftUI

/// Protocol to tell how to create custom views to combine with SSUI's views
public protocol SSUICustomizer {
    /// SSUI provides a few loading indicators, but if you want to create your own indicator, specify the style for loading screen
    /// to be "custom" in the config json and implement this method. If you do not use "custom" style in the json, you can simply
    /// return an empty view, this method will not be called anyway.
    var customLoadingIndicator: AnyView? { get }
    var infoIcon: AnyView { get }
    var deleteView: AnyView { get }
    var keyboardDismissButtonConfig: (config: SSUIViewConfig, text: String)? { get }
    var backableTopBarConfig: (titleConfig: SSUIViewConfig, backArrow: AnyView?, closeImage: AnyView?)? { get }
}
