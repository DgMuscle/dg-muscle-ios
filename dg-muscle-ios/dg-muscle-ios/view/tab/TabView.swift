//
//  TabView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI

struct TabView: View {
    @Binding var selectedTab: TabItemsView.Tab
    let settingViewDependency: SettingViewDependency
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .temp:
                VStack {
                    Text("temp")
                    Spacer()
                }
                
            case .setting:
                SettingView(dependency: settingViewDependency)
            }
            TabItemsView(selectedTab: $selectedTab)
        }
        
    }
}
