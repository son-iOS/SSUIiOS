//
//  SSUICoverView.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

struct SSUICoverView<RootContent>: View where RootContent: View {
    
    @Binding private var isPresented: Bool
    private let rootView: RootContent
    private let content: () -> AnyView?
    private let backgroundColor: SSUIColor
    private let position: SSUIPosition.Vertical
    
    private let isAnimated: Bool
    
    init(isPresented: Binding<Bool>, rootView: RootContent, position: SSUIPosition.Vertical,
         backgroundColor: SSUIColor, animationDuration: TimeInterval, @ViewBuilder content: @escaping () -> AnyView?) {
        self._isPresented = isPresented.animation(.easeInOut(duration: animationDuration))
        self.rootView = rootView
        self.backgroundColor = backgroundColor
        self.position = position
        self.content = content
        
        isAnimated = animationDuration > 0
    }
    
    var body: some View {
        let transition: AnyTransition = position == .middle ? .offset(y: -UIScreen.main.bounds.height)
            : .move(edge: position == .top ? .top : .bottom)
        return ZStack {
            rootView.zIndex(0)
            if isPresented {
                backgroundColor.colorAsView.edgesIgnoringSafeArea(.all).zIndex(1)
                if isAnimated {
                    VStack {
                        if position == .bottom || position == .middle {
                            Spacer()
                        }
                        content()
                        if position == .top || position == .middle {
                            Spacer()
                        }
                    }
                    .zIndex(2).transition(transition).animation(.linear)
                    .edgesIgnoringSafeArea(.vertical)
                } else {
                    VStack {
                        if position == .bottom || position == .middle {
                            Spacer()
                        }
                        content()
                        if position == .top || position == .middle {
                            Spacer()
                        }
                    }
                    .zIndex(2)
                    .edgesIgnoringSafeArea(.vertical)
                }
            }
        }
    }
}
