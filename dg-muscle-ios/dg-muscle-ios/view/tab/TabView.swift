//
//  TabView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI

struct TabView: View {
    struct settingViewDependency: SettingViewDependency {
        var tapProfile: (() -> ())?
        var error: ((Error) -> ())?
        
        func signOut() throws {
            try Authenticator().signOut()
        }
    }
    
    let settingDependency: settingViewDependency = .init {
        print("tap profile")
    } error: { error in
        print(error.localizedDescription)
    }

    
    var body: some View {
        VStack {
            SettingView(dependency: settingDependency)
            
            Text("Tab")
        }
        
    }
}
