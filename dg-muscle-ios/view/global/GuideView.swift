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
    
    var body: some View {
        ZStack {
            if let url = URL(string: "https://judicious-hoof-33e.notion.site/dg-muscle-app-guide-2f58d99c886b458eaca6b82f1403fa4b") {
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
