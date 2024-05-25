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
    
    public init(
        userRepository: any UserRepository,
        tapExerciseListItem: (() -> ())?,
        tapProfileListItem: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(userRepository: userRepository)
        )
        self.tapExerciseListItem = tapExerciseListItem
        self.tapProfileListItem = tapProfileListItem
    }
    
    public var body: some View {
        List {
            Section {
                VStack(spacing: 20) {
                    Button {
                        tapProfileListItem?()
                    } label: {
                        ListItemView(systemName: "person", text: "Profile", color: .red)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        tapExerciseListItem?()
                    } label: {
                        ListItemView(systemName: "dumbbell", text: "Exercise", color: .purple)
                    }
                    .buttonStyle(.borderless)
                }
            } header: {
                if let user = viewModel.user {
                    UserItemView(user: user)
                        .padding(.bottom)
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
        tapProfileListItem: nil
    )
        .preferredColorScheme(.dark)
}
