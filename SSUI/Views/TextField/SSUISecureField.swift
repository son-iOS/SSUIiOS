//
//  SSUISecureField.swift
//  Okee
//
//  Created by Son Nguyen on 11/28/20.
//

import Foundation
import SwiftUI

public struct SSUISecureField: View, SSUIInfoExpandableView {
    
    let hasAdditionalInfo: Bool
    let title: String
    let text: Binding<String>
    let onCommit: (() -> Void)?
    
    public init(_ title: String, text: Binding<String>, hasAdditionalInfo: Bool = false, onCommit: (() -> Void)? = nil) {
        self.title = title
        self.text = text
        self.hasAdditionalInfo = hasAdditionalInfo
        self.onCommit = onCommit
    }
    
    public var body: some View {
        
        let stack = ZStack {
            SecureField(title, text: text) {
                onCommit?()
            }
            
            if text.wrappedValue != "" && !hasAdditionalInfo {
                HStack {
                    Spacer()
                    Button(action: {
                        text.wrappedValue = ""
                    }, label: {
                        SSUI.shared.customizer?.deleteView
                    })
                }
            }
        }.animation(.linear)
        
        return stack
    }
    
    public func addInfo(title: SSUIAlert.Title, info: SSUIAlert.Message, type: AnyHashable, dismissButton: SSUIAlert.Action, isInfoShown: Binding<Bool>, alert: Binding<SSUIAlert?>) -> AnyView {
        self.addInfo(view: self.anyView, title: title, info: info, type: type, dismissButton: dismissButton, isInfoShown: isInfoShown, alert: alert)
    }
}
