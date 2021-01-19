//
//  SSUIWebView.swift
//  Okee
//
//  Created by Son Nguyen on 1/16/21.
//

import Foundation
import SwiftUI
import WebKit

public struct SSUIWebView: UIViewRepresentable {
   
    let localHtml: String?
    
    init(localHtml: String?) {
        self.localHtml = localHtml
    }
    
    public static func localHtml(filename: String) -> SSUIWebView {
        return SSUIWebView(localHtml: filename)
    }
   
    public func makeUIView(context: Context) -> WKWebView {
        return localHtlmView
    }
     
    private var localHtlmView: WKWebView {
        let wconfiguration = WKWebViewConfiguration()
                  
        //-- false = Play video with native device player ; true =  inline
        wconfiguration.allowsInlineMediaPlayback = false
        //-- Does not require user inter action for .ie sound auto playback
        wconfiguration.mediaTypesRequiringUserActionForPlayback = []

        let webView =  WKWebView(frame: .zero, configuration: wconfiguration)
        let theFileName = ((localHtml ?? "") as NSString).lastPathComponent
        let htmlPath = Bundle.main.path(forResource: theFileName, ofType: "html")
        let folderPath = Bundle.main.bundlePath
        let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)

        do {
          let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
          webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
        } catch {}

        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = true
        webView.isOpaque = false
        webView.isHidden = false

        return webView
    }
       
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SSUIWebView>) {}
}
