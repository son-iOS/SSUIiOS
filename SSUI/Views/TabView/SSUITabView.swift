//
//  SSUITabView.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUITabView: View {

    private let items: [TabViewItem]
    private let config: SSUITabViewConfig
    @State private var selectedItem = 0
    @ObservedObject private var keyboard = SSUIKeyboardResponder.shared
    
    public init(config: SSUITabViewConfig, @ViewBuilder items: () -> [TabViewItem]) {
        self.items = items()
        self.config = config
    }

    public var body: some View {
        for index in 0..<self.items.count {
            self.items[index].label.setup(index: index, selectedIndex: $selectedItem, isFullWidth: config.fullWidth ?? true, effect: config.selectionEffect ?? .none)
            let isShown = Binding<Bool> { () -> Bool in
                selectedItem == index
            } set: { (_) in }
            self.items[index].content.setIsShown(isShown)
        }

        let viewConfig = SSUIViewConfig(backgroundColor: config.backgroundColor, corners: config.corner,
                                        stroke: config.stroke, shadow: config.shadow)

        let tabs = HStack(spacing: 0) {
            ForEach((0..<items.count), id: \.self) { index -> AnyView in
                items[index].label.view
            }
        }
        .clipped()
        .frame(maxWidth: config.fullWidth ?? false ? .infinity : nil)
        .applySSUIConfig(viewConfig)

        let view = items[selectedItem].content.view.frame(maxWidth: .infinity, maxHeight: .infinity)
        if config.fullWidth ?? false {
            return VStack(spacing: 0) {
                view
                if keyboard.currentHeight <= 0 {
                    tabs
                }
            }
            .background(config.contentBackground?.colorAsView ?? Color.clear.anyView)
            .edgesIgnoringSafeArea(.bottom).anyView
        } else {
            return ZStack {
                view
                if keyboard.currentHeight <= 0 {
                    VStack {
                        Spacer()
                        tabs
                    }
                }
            }.anyView
        }
    }

    public struct TabViewItem {

        var label: SSUITabViewLabel
        let content: SSUITabViewContent

        public init(label: SSUITabViewLabel, content: SSUITabViewContent) {
            self.label = label
            self.content = content
        }
    }
}
