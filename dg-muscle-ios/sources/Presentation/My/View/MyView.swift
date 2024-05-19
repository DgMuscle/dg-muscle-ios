//
//  MyView.swift
//  My
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher

public struct MyView: View {
    @StateObject var viewModel: MyViewModel
    
    public init(userRepository: any UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        List {
            Section {
                Text("My")
            } header: {
                if let user = viewModel.user {
                    UserItemView(user: user)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return MyView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
