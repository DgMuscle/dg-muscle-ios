//
//  MyProfileEditView.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI
import MockData
import Domain
import PhotosUI

public struct MyProfileEditView: View {
    
    @StateObject var viewModel: MyProfileEditViewModel
    @Binding var isEditing: Bool
    
    public init(
        userRepository: UserRepository,
        isEditing: Binding<Bool>
    ) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
        _isEditing = isEditing
    }
    
    public var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                topSection
                Spacer()
                profileImageView
            }
        }
    }
    
    var backgroundView: some View {
        Rectangle()
            .fill(.clear)
            .background {
                ZStack {
                    PhotosPicker(
                        selection: $viewModel.selectedBackgroundPhoto,
                        label: {
                            if let image = viewModel.backgroundImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Rectangle()
                                    .fill(.gray)
                            }
                        }
                    )
                }
            }
            .ignoresSafeArea()
    }
    
    var topSection: some View {
        HStack {
            Button {
                isEditing = false
            } label: {
                Text("Cancel")
            }
            
            Spacer()
            
            Text("Done")
        }
        .padding(.horizontal)
        .foregroundStyle(.white)
    }
    
    var profileImageView: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(.white.opacity(0.6))
            .frame(width: 100, height: 100)
            .background {
                PhotosPicker(selection: $viewModel.selectedUserPhoto) {
                    if let image = viewModel.userImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.gray)
                            
                            Image(systemName: "person")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $viewModel.selectedUserPhoto) {
                            Image(systemName: "camera.fill")
                                .foregroundStyle(.black)
                                .background {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 30, height: 30)
                                }
                        }
                    }
                }
            }
    }
}

#Preview {
    MyProfileEditView(
        userRepository: UserRepositoryMock(),
        isEditing: .constant(true)
    )
    .preferredColorScheme(.dark)
}
