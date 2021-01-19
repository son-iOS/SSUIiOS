//
//  SSUISource.swift
//  Okee
//
//  Created by Son Nguyen on 10/30/20.
//

import Foundation

public struct SSUISource {
    internal let colorTheme: String?
    internal let button: String?
    internal let text: String?
    internal let textfield: String?
    internal let image: String?
    internal let loadingScreen: String?
    internal let alert: String?
    internal let tabView: String?
    internal let form: String?
    internal let panel: String?
    
    public init(colorTheme: String? = nil, button: String? = nil, text: String? = nil, textfield: String? = nil, image: String? = nil, loadingScreen: String? = nil, alert: String? = nil, tabView: String? = nil, form: String? = nil, panel: String? = nil) {
        self.colorTheme = colorTheme
        self.button = button
        self.text = text
        self.textfield = textfield
        self.image = image
        self.loadingScreen = loadingScreen
        self.alert = alert
        self.tabView = tabView
        self.form = form
        self.panel = panel
    }
}
