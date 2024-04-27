//
//  UpdateProfilePhotoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/17/24.
//

import SwiftUI
import PhotosUI

struct UpdateProfilePhotoView: View {
    
    @StateObject var viewModel: UpdateProfilePhotoViewModel
    
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
            
            VStack {
                Button {
                    viewModel.save()
                } label: {
                    HStack {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    }
                    .padding()
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
            
            
            Spacer()
        }
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.uiimage)
    }
}

#Preview {
    let viewModel: UpdateProfilePhotoViewModel = .init(userRepository: UserRepositoryV2Test(),
                                                       fileUploader: FileUploaderTest())
    return UpdateProfilePhotoView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
