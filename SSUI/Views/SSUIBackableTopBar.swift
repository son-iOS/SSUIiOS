//
//  SSUIBackableTopBar.swift
//  Okee
//
//  Created by Son Nguyen on 12/19/20.
//

import Foundation
import SwiftUI

public struct SSUIBackableTopBar: View {
    
    enum BackButton {
        case close
        case arrow
    }
    
    let title: String
    let backButton: BackButton
    let backgroundView: AnyView?
    
    let dismissAction: (() -> Void)?
    let isPresented: Binding<Bool>?
    
    private init(title: String, backButton: SSUIBackableTopBar.BackButton, dismissAction: (() -> Void)?, isPresented: Binding<Bool>?, backgroundView: AnyView?) {
        self.title = title
        self.backButton = backButton
        self.dismissAction = dismissAction
        self.isPresented = isPresented
        self.backgroundView = backgroundView
    }

    public var body: some View {
        ZStack {
            Text(title).applySSUIConfig(SSUI.shared.customizer?.backableTopBarConfig?.titleConfig)
            HStack {
                Button(action: {
                    dismissAction?()
                    isPresented?.wrappedValue = false
                }, label: {
                    backButton == .close
                        ? (SSUI.shared.customizer?.backableTopBarConfig?.closeImage ?? EmptyView().anyView)
                        : (SSUI.shared.customizer?.backableTopBarConfig?.backArrow ?? EmptyView().anyView)
                })
                Spacer()
            }.padding(.horizontal, 20).padding(.vertical, 10)
        }
        .padding(.vertical, 10)
        .background(backgroundView ?? Color.clear.anyView)
    }
    
    public static func close(isPresented: Binding<Bool>, title: String, backgroundView: AnyView? = nil) -> SSUIBackableTopBar {
        return SSUIBackableTopBar(title: title, backButton: .close, dismissAction: nil,
                              isPresented: isPresented, backgroundView: backgroundView)
    }
    
    public static func close(title: String, backgroundView: AnyView? = nil, dismissAction: @escaping () -> Void) -> SSUIBackableTopBar {
        return SSUIBackableTopBar(title: title, backButton: .close, dismissAction: dismissAction,
                              isPresented: nil, backgroundView: backgroundView)
    }
    
    public static func arrow(isPresented: Binding<Bool>, title: String, backgroundView: AnyView? = nil) -> SSUIBackableTopBar {
        return SSUIBackableTopBar(title: title, backButton: .arrow, dismissAction: nil, isPresented:
                                isPresented, backgroundView: backgroundView)
    }
    
    public static func arrow(title: String, backgroundView: AnyView? = nil, dismissAction: @escaping () -> Void) -> SSUIBackableTopBar {
        return SSUIBackableTopBar(title: title, backButton: .arrow, dismissAction: dismissAction,
                              isPresented: nil, backgroundView: backgroundView)
    }
}
