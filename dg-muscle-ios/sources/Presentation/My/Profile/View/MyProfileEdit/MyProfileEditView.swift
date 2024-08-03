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
import Common

public struct MyProfileEditView: View {
    
    @StateObject var viewModel: MyProfileEditViewModel
    @Binding var isEditing: Bool
    
    @State var isEditingDisplayName: Bool = false
    @State var isEditingLink: Bool = false
    
    @State var snackbarMessage: String?
    
    private let makeURLFromStringUsecase: MakeURLFromStringUsecase
    private let makeStringFromURLUsecase: MakeStringFromURLUsecase
    
    public init(
        userRepository: UserRepository,
        isEditing: Binding<Bool>
    ) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
        _isEditing = isEditing
        makeURLFromStringUsecase = .init()
        makeStringFromURLUsecase = .init()
    }
    
    public var body: some View {
        ZStack {
            backgroundView
            VStack {
                topSection
                Spacer()
                profileImageView
                    .padding(.bottom)
                labels
                    .padding(.horizontal)
            }
            
            if isEditingDisplayName {
                displayNameForm
            } else if isEditingLink {
                linkForm
            }
        }
        .overlay {
            if snackbarMessage != nil {
                Common.SnackbarView(message: $snackbarMessage)
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
                                    .contextMenu {
                                        Button("Delete", systemImage: "trash") {
                                            viewModel.deleteBackgroundImage()
                                        }
                                    }
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
        RoundedRectangle(cornerRadius: 40)
            .stroke(.white.opacity(0.6))
            .frame(width: 100, height: 100)
            .background {
                PhotosPicker(selection: $viewModel.selectedUserPhoto) {
                    if let image = viewModel.userImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .contextMenu {
                                Button("Delete", systemImage: "trash") {
                                    viewModel.deleteUserPhoto()
                                }
                            }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
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
    
    var labels: some View {
        VStack(spacing: 20) {
            Button {
                if isEditingDisplayName == false {
                    isEditingDisplayName = true
                }
            } label: {
                WhiteUnderlineTextLabel(text: viewModel.displayName)
            }
            
            Button {
                isEditingLink = true
            } label: {
                if let link = viewModel.link {
                    WhiteUnderlineTextLabel(text: makeStringFromURLUsecase.implement(url: link))
                } else {
                    WhiteUnderlineTextLabel(text: "Enter a link to express yourself")
                }
            }
        }
    }
    
    var displayNameForm: some View {
        return ProfileTextInputView(
            text: viewModel.displayName,
            showing: $isEditingDisplayName,
            maxLength: 20
        ) { value in
            viewModel.setDisplayName(value)
        }
    }
    
    var linkForm: some View {
        ProfileTextInputView(
            text: viewModel.link?.absoluteString ?? "",
            showing: $isEditingLink,
            maxLength: 200) { value in
                
                if value.isEmpty {
                    viewModel.setLink(nil)
                    return
                }
                
                let link = makeURLFromStringUsecase.implement(link: value)
                
                viewModel.setLink(link)
                
                if link == nil {
                    snackbarMessage = "Please enter a valid URL"
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
