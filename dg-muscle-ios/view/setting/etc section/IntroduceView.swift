//
//  IntroduceView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/10/24.
//

import SwiftUI

struct IntroduceView: View {
    @State var loading = false
    @State var error: Error?
    
    var isKorean: Bool {
        let preferredLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let isKorean = preferredLanguages?.first == "ko"
        return isKorean
    }
    
    var url: String {
        if isKorean {
            return "https://judicious-hoof-33e.notion.site/dgmuscle-ios-ko-a40c39718610412599b9d6ee2f0ad5a4"
        } else {
            return "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd"
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
        .navigationTitle("Introduce")
    }
}

#Preview {
    IntroduceView().preferredColorScheme(.dark)
}
