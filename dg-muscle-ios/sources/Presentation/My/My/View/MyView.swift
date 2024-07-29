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
    
    let presentProfileViewAction: (() -> Void)?
    
    public init(
        userRepository: any UserRepository,
        logRepository: LogRepository,
        presentProfileViewAction: (() -> Void)?
    ) {
        _viewModel = .init(
            wrappedValue: .init(userRepository: userRepository, 
                                logRepository: logRepository)
        )
        self.presentProfileViewAction = presentProfileViewAction
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
                        presentProfileViewAction?()
                    } label: {
                        ListItemView(systemName: "person", text: "Profile", color: Color(uiColor: .secondaryLabel))
                    }
                    .buttonStyle(.borderless)
                    
                    
                    Button {
                        URLManager.shared.open(url: "dgmuscle://friend")
                    } label: {
                        ListItemView(systemName: "link", text: "Friend", color: Color(uiColor: .secondaryLabel))
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        URLManager.shared.open(url: "dgmuscle://exercisemanage")
                    } label: {
                        ListItemView(systemName: "dumbbell", text: "Exercise", color: Color(uiColor: .secondaryLabel))
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        URLManager.shared.open(url: "dgmuscle://rapidsearchtype")
                    } label: {
                        ListItemView(systemName: "doc", text: "Exercise DB", color: Color(uiColor: .secondaryLabel))
                    }
                    .buttonStyle(.borderless)
                    
                    if viewModel.user?.developer == true {
                        Button {
                            URLManager.shared.open(url: "dgmuscle://logs")
                        } label: {
                            ListItemView(systemName: "doc", text: "Logs", color: Color(uiColor: .secondaryLabel))
                        }
                        .buttonStyle(.borderless)
                        .overlay {
                            if viewModel.hasLogBadge {
                                HStack {
                                    Circle().fill(.red)
                                        .frame(width: 4)
                                        .offset(x: 4, y: -8)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            } header: {
                if let user = viewModel.user {
                    
                    Button {
                        presentProfileViewAction?()
                    } label: {
                        let size: CGFloat = 50
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.clear)
                                .strokeBorder(.white.opacity(0.7), lineWidth: 1)
                                .frame(width: size, height: size)
                                .background {
                                    ZStack {
                                        if let url = user.photoURL {
                                            KFImage(url)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: size, height: size)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        } else {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.gray)
                                            Image(systemName: "person")
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                                .padding(.trailing, 10)
                            
                            Text(user.displayName ?? "null")
                                .foregroundStyle(Color(uiColor: .label))
                        }
                        .padding(.bottom)
                    }
                    .buttonStyle(.plain)
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
                        .foregroundStyle(.red)
                }
            }
        }
        .scrollIndicators(.hidden)
        .animation(.default, value: viewModel.errorMessage)
    }
}

#Preview {
    return MyView(
        userRepository: UserRepositoryMock(),
        logRepository: LogRepositoryMock(),
        presentProfileViewAction: nil
    )
        .preferredColorScheme(.dark)
}
