//
//  SSUIFrame.swift
//  Okee
//
//  Created by Son Nguyen on 12/31/20.
//

import Foundation
import SwiftUI

public struct SSUIFrame: Decodable {
    
    let minWidth: CGFloat?
    let width: CGFloat?
    let maxWidth: CGFloat?
    let minHeight: CGFloat?
    let height: CGFloat?
    let maxHeight: CGFloat?
    
    let expandVertically: Bool?
    let expandHorizontally: Bool?
    
    let topPadding: CGFloat?
    let bottomPadding: CGFloat?
    let verticalPadding: CGFloat?
    
    let leadingPadding: CGFloat?
    let trailingPadding: CGFloat?
    let horizontalPadding: CGFloat?
    
    public init(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil,
                minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil,
                expandVertically: Bool? = nil, expandHorizontally: Bool? = nil,
                topPadding: CGFloat? = nil, bottomPadding: CGFloat? = nil, verticalPadding: CGFloat? = nil,
                leadingPadding: CGFloat? = nil, trailingPadding: CGFloat? = nil, horizontalPadding: CGFloat? = nil) {
        self.minWidth = minWidth
        self.width = idealWidth
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.height = idealHeight
        self.maxHeight = maxHeight
        self.expandVertically = expandVertically
        self.expandHorizontally = expandHorizontally
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        self.verticalPadding = verticalPadding
        self.leadingPadding = leadingPadding
        self.trailingPadding = trailingPadding
        self.horizontalPadding = horizontalPadding
    }
    
    public static func fixedSize(width: CGFloat?, height: CGFloat?) -> SSUIFrame {
        return SSUIFrame(idealWidth: width, idealHeight: height)
    }
    
    public static var maxSize: SSUIFrame {
        return SSUIFrame(expandVertically: true, expandHorizontally: true)
    }
    
    public static var maxHeight: SSUIFrame {
        return SSUIFrame(expandVertically: true)
    }
    
    public static var maxWidth: SSUIFrame {
        return SSUIFrame(expandHorizontally: true)
    }
    
    public static func noPadding(minWidth: CGFloat? = nil, idealWidth: CGFloat? = nil, maxWidth: CGFloat? = nil,
                                 minHeight: CGFloat? = nil, idealHeight: CGFloat? = nil, maxHeight: CGFloat? = nil,
                                 expandVertically: Bool? = nil, expandHorizontally: Bool? = nil) -> SSUIFrame {
        return SSUIFrame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth,
                         minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight,
                         expandVertically: expandVertically, expandHorizontally: expandHorizontally)
    }
    
    public static func onlyPadding(topPadding: CGFloat? = nil, bottomPadding: CGFloat? = nil, verticalPadding: CGFloat? = nil,
                                   leadingPadding: CGFloat? = nil, trailingPadding: CGFloat? = nil, horizontalPadding: CGFloat? = nil) -> SSUIFrame {
        return SSUIFrame(topPadding: topPadding, bottomPadding: bottomPadding, verticalPadding: verticalPadding,
                         leadingPadding: leadingPadding, trailingPadding: trailingPadding, horizontalPadding: horizontalPadding)
    }
    
    var isStrictFrame: Bool {
        return minWidth == nil && minHeight == nil && maxHeight == nil && maxWidth == nil && height != nil && width != nil
    }
    
    var shouldApplyFrame: Bool {
        return !(minWidth == nil && minHeight == nil && maxHeight == nil && maxWidth == nil
            && height == nil && width == nil && expandVertically == nil && expandHorizontally == nil)
    }
}

public extension View {
    func applySSUIFrame(_ frame: SSUIFrame?) -> AnyView {
        guard let frame = frame else {
            return self.anyView
        }
        
        let maxWidth: CGFloat? = frame.expandHorizontally ?? false ? .infinity : frame.maxWidth
        let maxHeight: CGFloat? = frame.expandVertically ?? false ? .infinity : frame.maxHeight
        
        var topPadding: CGFloat? = frame.topPadding
        var bottomPadding: CGFloat? = frame.bottomPadding
        if let verticalPadding = frame.verticalPadding {
            topPadding = verticalPadding
            bottomPadding = verticalPadding
        }
        
        var leadingPadding: CGFloat? = frame.leadingPadding
        var trailingPadding: CGFloat? = frame.trailingPadding
        if let horizontalPadding = frame.horizontalPadding {
            leadingPadding = horizontalPadding
            trailingPadding = horizontalPadding
        }
        
        var view: AnyView = self.anyView
        
        view = applyPading(view: view, edge: .top, value: topPadding)
        view = applyPading(view: view, edge: .bottom, value: bottomPadding)
        view = applyPading(view: view, edge: .leading, value: leadingPadding)
        view = applyPading(view: view, edge: .trailing, value: trailingPadding)
        
        if frame.shouldApplyFrame {
            if frame.isStrictFrame {
                view = view.frame(width: frame.width, height: frame.height).anyView
            } else {
                view = view.frame(minWidth: frame.minWidth, idealWidth: frame.width, maxWidth: maxWidth,
                                  minHeight: frame.minHeight, idealHeight: frame.height, maxHeight: maxHeight).anyView
            }
        }
        
        return view
    }
    
    private func applyPading(view: AnyView, edge: Edge.Set, value: CGFloat?) -> AnyView {
        if value == -1 {
            return view.padding(edge).anyView
        } else if let value = value {
            return view.padding(edge, value).anyView
        }
        return view
    }
}
