//
//  SSUITextField.swift
//  Okee
//
//  Created by Son Nguyen on 11/28/20.
//

import Foundation
import SwiftUI

public struct SSUITextField: View, SSUIInfoExpandableView {
    
    let hasAdditionalInfo: Bool
    let showClearButton: Bool
    let title: String
    let text: Binding<String>
    let onEditingChanged: ((Bool) -> Void)?
    let onCommit: (() -> Void)?
    
    @State private var isEditting: Bool = false
    
    public init(_ title: String, text: Binding<String>, hasAdditionalInfo: Bool = false, showClearButton: Bool = true, onEditingChanged: ((Bool) -> Void)? = nil, onCommit: (() -> Void)? = nil) {
        self.title = title
        self.text = text
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.hasAdditionalInfo = hasAdditionalInfo
        self.showClearButton = showClearButton
    }
    
    public var body: some View {
        let stack = ZStack {
            TextField(title, text: text) { (editing) in
                onEditingChanged?(editing)
                isEditting = editing
            } onCommit: {
                onCommit?()
                isEditting = false
            }
            
            if text.wrappedValue != "" && isEditting && !hasAdditionalInfo && showClearButton {
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
