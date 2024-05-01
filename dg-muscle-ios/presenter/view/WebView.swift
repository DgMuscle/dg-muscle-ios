//
//  WebView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import SwiftUI

struct WebView: View {
    var url: String
    var body: some View {
        DGWebViewPresenter(url: url)
            .navigationBarTitleDisplayMode(.inline)
    }
}
