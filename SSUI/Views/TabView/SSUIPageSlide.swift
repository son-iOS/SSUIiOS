//
//  SSUIPageSlide.swift
//  Okee
//
//  Created by Son Nguyen on 1/14/21.
//

import Foundation
import SwiftUI

public struct SSUIPageSlide: View {
    
    @State private var selection = 0
    
    let pages: [AnyView]
    let config: SSUIPageSlideConfig
    var controls: (Binding<Int>) -> AnyView
    
    public init(config: SSUIPageSlideConfig, @ViewBuilder pages: () -> [AnyView], controls: @escaping (Binding<Int>) -> AnyView) {
        self.pages = pages()
        self.config = config
        self.controls = controls
    }
    
    public var body: some View {
        switch config.indicator.style {
        case .system, .none:
            return ZStack {
                TabView(selection: $selection) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        pages[index].tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: config.indicator.style == .system ? .automatic : .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: config.indicator.style == .system ? .automatic : .never))
                .animation(.linear)
                .applySSUIConfig(config.config)
                
                controls(selectionBinding)
            }
            .anyView
        case .slidingBar:
            return ZStack {
                TabView(selection: $selection) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        pages[index].tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.linear)
                
                VStack {
                    Spacer()
                    
                    SSUIPageIndicator(selection: $selection, style: config.indicator.style,
                                      count: pages.count, config: config.indicator.config)
                        .padding(.bottom, SSUI.safeAreaBottomInset != 0 ? SSUI.safeAreaBottomInset : nil)
                }
                
                controls(selectionBinding)
            }
            .applySSUIConfig(config.config)
            .anyView
        }
    }
    
    private var selectionBinding: Binding<Int> {
        Binding<Int>(get: {
            selection
        }, set: { (value) in
            guard value < pages.count && value >= 0 else {
                return
            }
            selection = value
        })
    }
}
