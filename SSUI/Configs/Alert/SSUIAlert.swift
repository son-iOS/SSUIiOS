//
//  SSUIAlert.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUIAlert {
    
    public struct Title {
        let text: String
        let config: SSUIViewConfig?
        
        var content: some View {
            Text(text).applySSUIConfig(config)
        }
        
        public init(text: String, config: SSUIViewConfig?) {
            self.text = text
            self.config = config
        }
    }
    public struct Message {
        let text: String
        let config: SSUIViewConfig?
        
        var content: some View {
            Text(text).applySSUIConfig(config)
        }
        
        public init(text: String, config: SSUIViewConfig?) {
            self.text = text
            self.config = config
        }
    }
    
    public struct Action {
        let label: AnyView
        let action: () -> Void
        
        public init(@ViewBuilder label: () -> AnyView, action: (() -> Void)? = nil) {
            self.label = label()
            self.action = action ?? {}
        }
        
        public static func text(_ text: String, config: SSUIViewConfig?, action: (() -> Void)? = nil) -> Action {
            return Action(label: { Text(text).applySSUIConfig(config).anyView }, action: action)
        }
        
        func content(isPresented: Binding<Bool>?) -> some View {
            let action = {
                isPresented?.wrappedValue = false
                self.action()
            }
            return Button(action: action, label: {label})
        }
    }
    
    let isPresented: Binding<Bool>?
    let type: AnyHashable
    let title: Title
    let message: Message
    let actions: [Action]
    let customView: AnyView?
    let customViewPosition: SSUIPosition.Vertical?
    
    public init(isPresented: Binding<Bool>?, type: AnyHashable, title: Title, message: Message, actions: [Action],
                customView: AnyView? = nil, customViewPosition: SSUIPosition.Vertical? = nil) {
        self.type = type
        self.isPresented = isPresented
        self.title = title
        self.message = message
        self.actions = actions
        self.customView = customView
        self.customViewPosition = customViewPosition
    }
    
    func getFullscreenContent(usingConfig config: SSUIAlertConfig?) -> some View {
        let viewConfig = SSUIViewConfig(backgroundColor: config?.backgroundColor, corners: config?.corners,
                                        stroke: config?.stroke, shadow: config?.shadow, frame: config?.frame)
        return VStack {
            if config?.contentPosition == .top {
                content.padding(.top, SSUI.safeAreaTopInset)
            }
            if config?.actionsPosition == .top {
                actionsContent(direction: config?.actionsStackDirection ?? .vertical)
                    .padding(.top, config?.contentPosition != .top ? SSUI.safeAreaTopInset : 0)
            }
            
            Spacer()
            
            if config?.contentPosition == .middle {
                content
            }
            if config?.actionsPosition == .middle {
                actionsContent(direction: config?.actionsStackDirection ?? .vertical)
            }
            
            Spacer()
            
            if config?.contentPosition == .bottom {
                content
                    .padding(.bottom, config?.actionsPosition != .bottom ? SSUI.safeAreaBottomInset : 0)
            }
            if config?.actionsPosition == .bottom {
                actionsContent(direction: config?.actionsStackDirection ?? .vertical)
                    .padding(.bottom, SSUI.safeAreaBottomInset)
            }
        }.applySSUIConfig(viewConfig)
    }
    
    func getNonFullscreenContent(usingConfig config: SSUIAlertConfig?) -> some View {
        let viewConfig = SSUIViewConfig(backgroundColor: config?.backgroundColor, corners: config?.corners,
                                        stroke: config?.stroke, shadow: config?.shadow, frame: config?.frame)
        return VStack {
            if config?.actionsPosition == .top {
                actionsContent(direction: config?.actionsStackDirection ?? .vertical)
                    .padding(.top, config?.contentPosition == .top && config?.actionsPosition == .top
                                ? SSUI.safeAreaTopInset
                                : 0)
            }
            content
                .padding(.top, config?.contentPosition == .top && config?.actionsPosition == .bottom
                            ? SSUI.safeAreaTopInset
                            : 0)
                .padding(.bottom, config?.contentPosition == .bottom && config?.actionsPosition == .top
                            ? SSUI.safeAreaBottomInset
                            : 0)
            if config?.actionsPosition == .bottom {
                actionsContent(direction: config?.actionsStackDirection ?? .vertical)
                    .padding(.bottom, config?.contentPosition == .bottom && config?.actionsPosition == .bottom
                                ? SSUI.safeAreaBottomInset
                                : 0)
            }
        }.applySSUIConfig(viewConfig)
    }
    
    private var content : some View {
        VStack {
            if customViewPosition == .top {
                customView
            }
            title.content
            if customViewPosition == .middle {
                customView
            }
            message.content
            if customViewPosition == .bottom {
                customView
            }
        }
    }
    
    private func actionsContent(direction: SSUIDirection.General) -> some View {
        switch direction {
        case .vertical:
            return VStack {
                ForEach((0..<actions.count), id: \.self) {index in
                    actions[index].content(isPresented: isPresented)
                }
            }.padding().anyView
        case .horizontal:
            return HStack {
                ForEach((0..<actions.count), id: \.self) {index in
                    actions[index].content(isPresented: isPresented)
                }
            }.anyView
        }
    }
}
