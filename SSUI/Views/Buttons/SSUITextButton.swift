//
//  SSUITextButton.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUITextButton<Title>: View where Title: StringProtocol {
    
    let title: Title
    let config: SSUIViewConfig
    let action: () -> Void
    
    public init(title: Title, config: SSUIViewConfig, action: @escaping () -> Void) {
        self.title = title
        self.config = config
        self.action = action
    }
    
    public var body: some View {
        return Button(action: action, label: {
            Text(title).applySSUIConfig(config)
        })
    }
}
