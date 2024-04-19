//
//  DGWebView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/19/24.
//

import SwiftUI
import WebKit
import SnapKit

struct DGWebViewPresenter: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> DGWebView {
        let webView = DGWebView()
        webView.load(url: url)
        return webView
    }
    
    func updateUIView(_ uiView: DGWebView, context: Context) {
        uiView.load(url: url)
    }
}

final class DGWebView: UIView {
    
    private let webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func configUI() {
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
