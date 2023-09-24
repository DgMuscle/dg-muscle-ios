//
//  TabItemsView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI

struct TabItemsView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Image(systemName: selectedTab == .temp ? "doc.fill" : "doc")
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation {
                        selectedTab = .temp
                    }
                }
                
            Image(systemName: selectedTab == .setting ? "gearshape.fill" : "gearshape")
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation {
                        selectedTab = .setting
                    }
                }
        }
        .padding(.top, 10)
    }
}

extension TabItemsView {
    enum Tab {
        case temp
        case setting
    }
}

