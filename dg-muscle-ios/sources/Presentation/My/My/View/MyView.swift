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
            
            if let errorMessage = viewModel.errorMessage {
                Common.StatusView(status: .error(errorMessage))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            viewModel.errorMessage = nil
                        }
                    }
            }
            
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
                
                Button {
                    URLManager.shared.open(url: "dgmuscle://deleteaccountconfirm")
                } label: {
                    Text("Delete Account")
                        .italic()
                }
            }
        }
        .scrollIndicators(.hidden)
        .animation(.default, value: viewModel.errorMessage)
    }
}

#Preview {
    return MyView(
        userRepository: UserRepositoryMock()
    )
        .preferredColorScheme(.dark)
}
