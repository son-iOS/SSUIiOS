//
//  SSUIForm.swift
//  Okee
//
//  Created by Son Nguyen on 1/1/21.
//

import Foundation
import SwiftUI

public struct SSUIForm {
    
    let content: () -> AnyView?
    let type: AnyHashable
    
    public init(type: AnyHashable, @ViewBuilder content: @escaping () -> AnyView) {
        self.type = type
        self.content = content
    }
    
    func getContent(usingConfig config: SSUIFormConfig?) -> some View {
        let viewConfig = SSUIViewConfig(backgroundColor: config?.backgroundColor,
                                        corners: config?.corners, stroke: config?.stroke,
                                        shadow: config?.shadow, frame: config?.frame)
        return content()?.applySSUIConfig(viewConfig)
    }
}
