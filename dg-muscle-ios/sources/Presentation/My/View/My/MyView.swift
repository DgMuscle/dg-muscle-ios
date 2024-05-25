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
    
    private let tapExerciseListItem: (() -> ())?
    private let tapProfileListItem: (() -> ())?
    private let tapFriendListItem: (() -> ())?
    
    public init(
        userRepository: any UserRepository,
        tapExerciseListItem: (() -> ())?,
        tapProfileListItem: (() -> ())?,
        tapFriendListItem: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(userRepository: userRepository)
        )
        self.tapExerciseListItem = tapExerciseListItem
        self.tapProfileListItem = tapProfileListItem
        self.tapFriendListItem = tapFriendListItem
    }
    
    public var body: some View {
        List {
            Section {
                VStack(spacing: 20) {
                    Button {
                        tapFriendListItem?()
                    } label: {
                        ListItemView(systemName: "person", text: "Friend", color: .green)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        tapExerciseListItem?()
                    } label: {
                        ListItemView(systemName: "dumbbell", text: "Exercise", color: .blue)
                    }
                    .buttonStyle(.borderless)
                }
            } header: {
                if let user = viewModel.user {
                    Button {
                        tapProfileListItem?()
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
        userRepository: UserRepositoryMock(),
        tapExerciseListItem: nil,
        tapProfileListItem: nil, 
        tapFriendListItem: nil
    )
        .preferredColorScheme(.dark)
}
