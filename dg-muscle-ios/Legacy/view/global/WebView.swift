//
//  WebView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/9/24.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    let url: URL
    
    @Binding var loading: Bool
    @Binding var error: Error?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Coordinator class
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ webView: WebView) {
            self.parent = webView
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Handle start of navigation/loading
            withAnimation {
                parent.loading = true
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Handle finish loading
            withAnimation {
                parent.loading = false
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Handle failure
            withAnimation {
                parent.error = error
            }
        }
    }
}

