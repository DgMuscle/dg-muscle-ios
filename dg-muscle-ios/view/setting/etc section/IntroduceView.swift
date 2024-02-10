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
    
    var body: some View {
        ZStack {
            if let url = URL(string: "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd") {
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
