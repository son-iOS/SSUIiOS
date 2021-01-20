//
//  SSUI.swift
//  Okee
//
//  Created by Son Nguyen on 10/30/20.
//

import Foundation
import SwiftUI

public class SSUI {
    public static let shared = SSUI()
    
    public static let safeAreaBottomInset: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    public static let safeAreaTopInset: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    internal var customizer: SSUICustomizer?
    
    public func setCustomizer(_ customizer: SSUICustomizer) {
        self.customizer = customizer
    }
}
