//
//  SSUIFullscreenBackgroundView.swift
//  Okee
//
//  Created by Son Nguyen on 12/2/20.
//

import Foundation
import SwiftUI

struct SSUIFullscreenBackgroundView: UIViewRepresentable {
    
    let color: UIColor?
    
    static let clear = SSUIFullscreenBackgroundView(color: .clear)
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = color ?? .clear
        // TODO: handle gradient
        DispatchQueue.main.async {
            var superView = view.superview
            while superView != nil {
                superView?.backgroundColor = .clear
                superView = superView?.superview
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
