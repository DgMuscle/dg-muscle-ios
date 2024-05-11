//
//  ProfilePhotoEditView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI
import PhotosUI

struct ProfilePhotoEditView: View {
    
    @StateObject var viewModel: ProfilePhotoEditViewModel
    
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                if let uiimage = viewModel.uiimage {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFit()
                } else {
                    HStack {
                        Image(systemName: "camera")
                        Text("PhotosPicker")
                    }
                    .fontWeight(.black)
                }
            }
            
            if viewModel.uiimage != nil {
                VStack {
                    Button {
                        viewModel.save()
                    } label: {
                        RoundedGradationText(text: "SAVE")
                    }
                    
                    Button {
                        viewModel.delete()
                    } label: {
                        HStack {
                            Spacer()
                            Text("DELETE")
                            Spacer()
                        }
                        .padding()
                        .foregroundStyle(.pink)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.uiimage)
    }
}

#Preview {
    
    let userRepository: UserRepository = UserRepositoryTest()
    let fileUploader: FileUploaderInterface = FileUploaderTest()
    
    let viewModel: ProfilePhotoEditViewModel = .init(
        postUserProfileImageUsecase: .init(userRepository: userRepository,
                                           fileUploader: fileUploader),
        deleteUserProfileImageUsecase: .init(userRepository: userRepository,
                                             fileUploader: fileUploader),
        getUserUsecase: .init(userRepository: userRepository))
    return ProfilePhotoEditView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
