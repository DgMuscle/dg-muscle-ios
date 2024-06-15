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
import Common

public struct MyView: View {
    @StateObject var viewModel: MyViewModel
    
    public init(
        userRepository: any UserRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(userRepository: userRepository)
        )
    }
    
    public var body: some View {
        List {
            Section {
                VStack(spacing: 20) {
                    Button {
                        URLManager.shared.open(url: "dgmuscle://friend")
                    } label: {
                        ListItemView(systemName: "person", text: "Friend", color: .green)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        URLManager.shared.open(url: "dgmuscle://exercisemanage")
                    } label: {
                        ListItemView(systemName: "dumbbell", text: "Exercise", color: .blue)
                    }
                    .buttonStyle(.borderless)
                }
            } header: {
                if let user = viewModel.user {
                    Button {
                        URLManager.shared.open(url: "dgmuscle://profile")
                    } label: {
                        UserItemView(user: user)
                            .padding(.bottom)
                    }
                }
            }
            
            Section {
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Sign Out")
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return MyView(
        userRepository: UserRepositoryMock()
    )
        .preferredColorScheme(.dark)
}
