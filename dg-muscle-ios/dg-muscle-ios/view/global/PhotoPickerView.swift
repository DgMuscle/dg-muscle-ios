//
//  PhotoPickerView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI
import PhotosUI

protocol PhotoPickerViewDependency {
    func saveProfileImage(image: UIImage?)
}

struct PhotoPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State var uiImage: UIImage?
    @Binding var isShowing: Bool
    
    let dependency: PhotoPickerViewDependency
    private let buttonSize: CGFloat = 35
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color(uiColor: .systemBackground)).ignoresSafeArea()
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Select a photo")
                }
            }
            
            VStack {
                HStack(spacing: 30) {
                    Spacer()
                    Button {
                        withAnimation {
                            isShowing = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .background {
                                Circle().fill(.gray.opacity(0.6))
                                    .frame(width: buttonSize, height: buttonSize)
                            }
                    }
                    
                    Button {
                        dependency.saveProfileImage(image: uiImage)
                        withAnimation {
                            isShowing = false
                        }
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundStyle(.white)
                            .background {
                                Circle().fill(.gray.opacity(0.6))
                                    .frame(width: buttonSize, height: buttonSize)
                            }
                    }
                }
                .padding()
                Spacer()
            }
        }
        .onChange(of: selectedItem) { _, newValue in
            Task {
                guard let data = try? await newValue?.loadTransferable(type: Data.self) else { return }
                withAnimation {
                    uiImage = UIImage(data: data)
                }
            }
        }
    }
}
