//
//  SSUIViewModel.swift
//  Okee
//
//  Created by Son Nguyen on 1/2/21.
//
import Foundation
import SwiftUI
import Combine

open class SSUIViewModel: ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var alert: SSUIAlert?
    @Published public var form: SSUIForm?
    @Published public var dummy: Bool = false

    public var isLoadingBinding: Binding<Bool> {
        Binding<Bool> { [weak self] in
            self?.isLoading ?? false
        } set: {[weak self] (value) in
            self?.isLoading = value
        }
    }

    public var isAlertShownBinding: Binding<Bool> {
        Binding<Bool> { [weak self] () -> Bool in
            self?.alert != nil
        } set: { [weak self] (value) in
            if !value {
                self?.alert = nil
            }
        }
    }
    
    public var isFormShownBinding: Binding<Bool> {
        Binding<Bool> { [weak self] () -> Bool in
            self?.form != nil
        } set: { [weak self] (value) in
            if !value {
                self?.form = nil
            }
        }
    }
    
    public var alertBinding: Binding<SSUIAlert?> {
        Binding<SSUIAlert?> { [weak self] () -> SSUIAlert? in
            self?.alert
        } set: { [weak self] (value) in
            self?.alert = value
        }
    }
    
    public var formBinding: Binding<SSUIForm?> {
        Binding<SSUIForm?> { [weak self] () -> SSUIForm? in
            self?.form
        } set: { [weak self] (value) in
            self?.form = value
        }
    }
    
    /// Because SwiftUI fails to send notification on Published properties of subclass, we need
    /// to call this metho every time we update an Published property in subclass
    public func didSetAPublishedProperty() {
        dummy.toggle()
    }
    
    public init() {}
}
