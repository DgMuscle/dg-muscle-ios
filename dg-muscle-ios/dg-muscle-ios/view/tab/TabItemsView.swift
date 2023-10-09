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
            Button {
                selectedTab = .diary
            } label: {
                Image(systemName: selectedTab == .diary ? "doc.fill" : "doc")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(Color(uiColor: .label))
            
            Button {
                selectedTab = .setting
            } label: {
                Image(systemName: "ellipsis")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == .setting ? Color(uiColor: .label) : Color(uiColor: .secondaryLabel))
        }
        .padding(.top, 4)
        .padding(.bottom, 4)
    }
}

extension TabItemsView {
    enum Tab {
        case diary
        case setting
    }
}
