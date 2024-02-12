//
//  GuideView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/10/24.
//

import SwiftUI

struct GuideView: View {
    @State var loading = false
    @State var error: Error?
    
    var isKorean: Bool {
        let preferredLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let isKorean = preferredLanguages?.first == "ko-KR"
        return isKorean
    }
    
    var url: String {
        if isKorean {
            return "https://judicious-hoof-33e.notion.site/dgmuscle-app-guide-ko-51d0cb09dd9d42cba9fe6d8ad1e2aa79"
        } else {
            return "https://judicious-hoof-33e.notion.site/dg-muscle-app-guide-2f58d99c886b458eaca6b82f1403fa4b"
        }
    }
    
    var body: some View {
        ZStack {
            if let url = URL(string: url) {
                WebView(url: url, loading: $loading, error: $error)
            } else {
                Text("Fail to load.")
            }
        }
        .navigationTitle("App Guide")
    }
}

#Preview {
    GuideView().preferredColorScheme(.dark)
}
