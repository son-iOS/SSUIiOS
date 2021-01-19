//
//  SSUITextButton.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

struct SSUITextButton<Title>: View where Title: StringProtocol {
    let title: Title
    let config: SSUIViewConfig
    let action: () -> Void
    
    var body: some View {
        return Button(action: action, label: {
            Text(title).applySSUIConfig(config)
        })
    }
}
