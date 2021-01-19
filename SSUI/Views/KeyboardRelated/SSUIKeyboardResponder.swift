//
//  SSUIKeyboardResponder.swift
//  Okee
//
//  Created by Son Nguyen on 11/28/20.
//

import Foundation
import SwiftUI

public class SSUIKeyboardResponder: ObservableObject {
    
    public static let shared = SSUIKeyboardResponder()
    
    @Published public private(set) var currentHeight: CGFloat = 0
    public var duration: TimeInterval = 0.25

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            self.duration = duration
            self.currentHeight = keyboardSize.height + SSUI.safeAreaTopInset
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
