//
//  RapidSearchTypeListView.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import SwiftUI
import Common

public struct RapidSearchTypeListView: View {
    
    public init() {
        
    }
    
    public var body: some View {
        List {
            Button {
                Common.URLManager.shared.open(url: "dgmuscle://rapid_search_by_name")
            } label: {
                HStack {
                    Text("Search By Exercise Name")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color(uiColor: .label))
            }
            
            Button {
                Common.URLManager.shared.open(url: "dgmuscle://rapid_search_by_part")
            } label: {
                HStack {
                    Text("Search By Body Part")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .foregroundStyle(Color(uiColor: .label))
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Exercise DB")
        
    }
}

#Preview {
    NavigationStack {
        RapidSearchTypeListView()
            .preferredColorScheme(.dark)
    }
}
