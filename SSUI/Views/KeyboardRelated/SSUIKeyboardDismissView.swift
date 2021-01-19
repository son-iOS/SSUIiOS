//
//  SSUIKeyboardDismissView.swift
//  Okee
//
//  Created by Son Nguyen on 11/2/20.
//

import Foundation
import SwiftUI

public struct SSUIKeyboardDismissView<Content> : View where Content : View {
    @ObservedObject private var keyboard = SSUIKeyboardResponder.shared
    @State private var isDismissButtonShown: Bool = false
    private var view: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.view = content()
    }
    
    public var body: some View {
        let screenHeight = UIScreen.main.bounds.height
        ZStack {
            view
            if keyboard.currentHeight != 0 {
                VStack() {
                    HStack {
                        Spacer()
                        Button(SSUI.shared.customizer?.keyboardDismissButtonConfig?.text ?? "") {
                            keyboard.hideKeyboard()
                            isDismissButtonShown = false
                        }.applySSUIConfig(SSUI.shared.customizer?.keyboardDismissButtonConfig?.config)
                    }.offset(x: isDismissButtonShown ? 0 : 100)
                    .onAppear {
                        isDismissButtonShown = true
                    }
                }.frame(height: screenHeight - keyboard.currentHeight, alignment: .bottom)
            }
        }.animation(.linear(duration: keyboard.duration))
    }
}
