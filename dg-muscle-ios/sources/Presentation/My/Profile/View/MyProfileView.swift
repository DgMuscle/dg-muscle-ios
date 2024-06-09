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
    @State var isPresentImagePickerForProfilePhoto: Bool = false
    @State var isPresentImagePickerForBackground: Bool = false
    
    private let profilePhotoSize: CGFloat = 80
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        ZStack {
            
            if let image = viewModel.backgroundImage {
                Rectangle()
                    .fill(.clear)
                    .background(
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    )
                    .ignoresSafeArea()
            }
            
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
                
                Button {
                    isPresentImagePickerForProfilePhoto.toggle()
                } label: {
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
                }
                .foregroundStyle(Color(uiColor: .label))
                
                HStack {
                    Image(systemName: "pencil").hidden()

                    TextField("Display Name", text: $viewModel.displayName)
                        .multilineTextAlignment(.center)
                        .focused($displayNameFocus)
                        .fontWeight(.black)
                    Image(systemName: "pencil")
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
        .fullScreenCover(isPresented: $isPresentImagePickerForProfilePhoto) {
            Common.ImagePicker(image: $viewModel.profilePhoto)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $isPresentImagePickerForBackground) {
            Common.ImagePicker(image: $viewModel.backgroundImage)
                .ignoresSafeArea()
        }
        .overlay {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPresentImagePickerForBackground.toggle()
                    } label: {
                        Image(systemName: "camera")
                            .font(.title)
                            .padding(.trailing)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    return MyProfileView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
