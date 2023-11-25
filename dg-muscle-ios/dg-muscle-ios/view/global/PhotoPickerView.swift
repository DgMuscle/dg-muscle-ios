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
    @State private var localShowing = true
    
    @State var uiImage: UIImage?
    
    @Binding var isShowing: Bool
    
    let dependency: PhotoPickerViewDependency
    
    var body: some View {
        ZStack {
            if localShowing {
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
                    HStack(spacing: 15) {
                        Spacer()
                        
                        if uiImage != nil {
                            Button("delete photo") {
                                withAnimation {
                                    uiImage = nil
                                }
                            }
                            .foregroundStyle(.red)
                            .buttonBorderShape(.buttonBorder)
                        }
                        
                        Button {
                            withAnimation {
                                localShowing = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    Spacer()
                    
                    Button("save photo") {
                        dependency.saveProfileImage(image: uiImage)
                        withAnimation {
                            localShowing = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onChange(of: localShowing, { oldValue, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isShowing = false
            }
        })
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
