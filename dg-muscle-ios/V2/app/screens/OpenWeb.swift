//
//  OpenWeb.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/19/24.
//

import SwiftUI

struct OpenWeb: View {
    
    var url: String
    
    var body: some View {
        DGWebViewPresenter(url: url)
    }
}

#Preview {
    
    let url = "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd"
    
    return OpenWeb(url: url).preferredColorScheme(.dark)
}
