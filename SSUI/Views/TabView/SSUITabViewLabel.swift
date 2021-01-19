//
//  SSUITabViewLabel.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public class SSUITabViewLabel {
    
    let normal: AnyView
    let selected: AnyView?
    var isFullWidth: Bool = false
    var effect: SSUITabViewConfig.SelectionEffect = .none
    var index: Int = -1
    
    var selectedIndex: Binding<Int>?
    
    var view: AnyView {
        let button = Button(action: { [weak self] in
            guard self?.selectedIndex?.wrappedValue != self?.index else {
                return
            }
            self?.selectedIndex?.wrappedValue = self?.index ?? -1
        }, label: { [weak self] in
            self?.selectedIndex?.wrappedValue == self?.index ? self?.selected : self?.normal
        })
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .padding(.bottom, isFullWidth ? UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 34 : 0)
        
        switch effect {
        case .none:
            return button.anyView
        case .scale:
            return button
                .scaleEffect(selectedIndex?.wrappedValue == index ? 1.25 : 1)
                .animation(.linear(duration: 0.15))
                .anyView
        }
    }
    
    public init(@ViewBuilder normal: () -> AnyView, @ViewBuilder selected: () -> AnyView?) {
        self.normal = normal()
        self.selected = selected()
    }
    
    internal func setup(index: Int, selectedIndex: Binding<Int>, isFullWidth: Bool, effect: SSUITabViewConfig.SelectionEffect = .none) {
        self.index = index
        self.selectedIndex = selectedIndex
        self.isFullWidth = isFullWidth
        self.effect = effect
    }
}
