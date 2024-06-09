//
//  PageAnchorView.swift
//  Friend
//
//  Created by 신동규 on 6/9/24.
//

import SwiftUI
import Domain
import MockData

struct PageAnchorView: View {
    
    enum Page: String, Hashable, CaseIterable {
        case friend = "Friend"
        case search = "Search"
        case request = "Request"
    }
    
    @Binding var page: Page
    @StateObject var viewModel: PageAnchorViewModel
    private let badgeSize: CGFloat = 5
    
    init(
        page: Binding<Page>,
        friendRepository: FriendRepository
    ) {
        _page = page
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Page.allCases, id: \.self) { page in
                    
                    Button {
                        self.page = page
                    } label: {
                        Text(page.rawValue)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(uiColor: .label))
                    .overlay {
                        if page == .request && viewModel.hasRequest {
                            VStack {
                                HStack {
                                    Spacer()
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: badgeSize, height: badgeSize)
                                        .offset(x: -20)
                                }
                                Spacer()
                            }
                            
                        }
                    }
                }
            }
            GeometryReader(content: { geometry in
                Divider()
                    .frame(width: geometry.size.width / 3)
                    .background(Color(uiColor: .label))
                    .offset(x: dividerOffset(page: page, width: geometry.size.width))
            })
            .frame(height: 1)
            .animation(.default, value: page)
        }
    }
    
    private func dividerOffset(page: Page, width: CGFloat) -> CGFloat {
        switch page {
        case .friend:
            return 0
        case .search:
            return width / 3 * 1
        case .request:
            return width / 3 * 2
        }
    }
}

#Preview {
    
    @State var page: PageAnchorView.Page = .friend
    
    return PageAnchorView(
        page: $page,
        friendRepository: FriendRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
