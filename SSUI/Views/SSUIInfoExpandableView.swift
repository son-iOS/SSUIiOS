//
//  SSUIInfoExpandableView.swift
//  Okee
//
//  Created by Son Nguyen on 12/2/20.
//

import Foundation
import SwiftUI

public protocol SSUIInfoExpandableView {
    func addInfo(title: SSUIAlert.Title, info: SSUIAlert.Message, type: AnyHashable,
                 dismissButton: SSUIAlert.Action, isInfoShown: Binding<Bool>, alert: Binding<SSUIAlert?>) -> AnyView
}

extension SSUIInfoExpandableView {
    func addInfo(view: AnyView, title: SSUIAlert.Title, info: SSUIAlert.Message, type: AnyHashable,
                 dismissButton: SSUIAlert.Action, isInfoShown: Binding<Bool>, alert: Binding<SSUIAlert?>) -> AnyView {
        return ZStack {
            view
            HStack {
                Spacer()
                Button(action: {
                    alert.wrappedValue = SSUIAlert(isPresented: isInfoShown, type: type, title: title, message: info, actions: [dismissButton])
                    isInfoShown.wrappedValue = true
                }, label: {
                    SSUI.shared.customizer?.infoIcon
                })
            }
        }.anyView
    }
}
