//
//  SSUITabViewContent.swift
//  Okee
//
//  Created by Son Nguyen on 12/7/20.
//

import Foundation
import SwiftUI

public class SSUITabViewContent {
    
    let content: () -> AnyView
    
    private var isShown: Binding<Bool>?
    
    private var renderedView: AnyView?
    var view: AnyView {
        var renderedView: AnyView
        if self.renderedView == nil {
            renderedView = content()
            self.renderedView = renderedView
        } else {
            renderedView = self.renderedView!
        }
        return isShown?.wrappedValue ?? false ? renderedView : EmptyView().anyView
    }
    
    public init(@ViewBuilder content: @escaping () -> AnyView) {
        self.content = content
    }
    
    func setIsShown(_ isShown: Binding<Bool>) {
        self.isShown = isShown
    }
}
