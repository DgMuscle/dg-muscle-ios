//
//  MyProfileView.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import SwiftUI
import Domain
import MockData
import Common

public struct MyProfileView: View {
    
    @StateObject var viewModel: MyProfileViewModel
    @FocusState var displayNameFocus
    
    private let profilePhotoSize: CGFloat = 80
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                if let status = viewModel.status {
                    
                    switch status {
                    case .loading, .error:
                        Common.StatusView(status: status)
                    case .success:
                        Common.StatusView(status: status)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    viewModel.status = nil
                                }
                            }
                    }
                }
                
                Spacer()
                
                if let uiimage = viewModel.profilePhoto {
                    Image(uiImage: uiimage)
                        .resizable()
                        .frame(width: profilePhotoSize, height: profilePhotoSize)
                        .clipShape(
                            RoundedRectangle(cornerRadius: profilePhotoSize / 4)
                        )
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: profilePhotoSize / 4)
                            .fill(
                                Color(uiColor: .secondarySystemBackground)
                            )
                            .frame(width: profilePhotoSize, height: profilePhotoSize)
                        
                        Image(systemName: "person")
                            .font(.largeTitle)
                        
                    }
                }
                
                HStack {
                    Image(systemName: "pencil").hidden()
                        .font(.title)
                    TextField("Display Name", text: $viewModel.displayName)
                        .multilineTextAlignment(.center)
                        .focused($displayNameFocus)
                    Image(systemName: "pencil")
                        .font(.title)
                        .onTapGesture {
                            displayNameFocus.toggle()
                        }
                }
                
                Divider()
                
                Common.GradientButton(action: {
                    viewModel.save()
                }, text: "SAVE", backgroundColor: viewModel.color)
            }
            .padding(.horizontal)
            .animation(.default, value: viewModel.status)
        }
    }
}

#Preview {
    return MyProfileView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
