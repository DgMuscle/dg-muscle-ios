//
//  FriendListOptionsView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import SwiftUI

struct FriendListOptionsView: View {
    private let itemSize: CGFloat = 48
    private let badgeSize: CGFloat = 6
    @State private var expanded: Bool = false
    
    let hasRequest: Bool
    let requestAction: (() -> ())?
    let searchAction: (() -> ())?
    
    var body: some View {
        VStack(spacing: 0) {
            
            if expanded {
                VStack(spacing: 0) {
                    
                    Button {
                        requestAction?()
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: "envelope")
                                .frame(width: itemSize, height: itemSize)
                            Divider().frame(width: itemSize)
                        }
                        .overlay {
                            if hasRequest {
                                Circle()
                                    .frame(width: badgeSize, height: badgeSize).foregroundStyle(.red)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                    
                    Button {
                        searchAction?()
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: "magnifyingglass")
                                .frame(width: itemSize, height: itemSize)
                            Divider().frame(width: itemSize)
                        }
                    }
                }
            }
            
            Button {
                expanded.toggle()
            } label: {
                Image(systemName: "arrowshape.up")
                    .frame(width: itemSize, height: itemSize)
                    .rotationEffect(.degrees(expanded ? 180 : 0))
            }
        }
        .animation(.default, value: expanded)
        .foregroundStyle(Color(uiColor: .label))
        .background(
            RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemGroupedBackground))
        )
    }
}

#Preview {
    FriendListOptionsView(hasRequest: false,
                          requestAction: nil,
                          searchAction: nil)
    .preferredColorScheme(.dark)
    .previewLayout(.sizeThatFits)
}
