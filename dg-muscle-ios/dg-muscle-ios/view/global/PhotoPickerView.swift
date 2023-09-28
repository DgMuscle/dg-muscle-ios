//
//  PhotoPickerView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI
import PhotosUI

protocol PhotoPickerViewDependency {
    func savePhoto(image: UIImage?)
}

struct PhotoPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State var uiImage: UIImage?
    @Binding var isShowing: Bool
    
    let dependency: PhotoPickerViewDependency
    
    var body: some View {
        ZStack {
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
                    VStack(spacing: 8) {
                        Image(systemName: "plus.rectangle")
                            .font(.largeTitle)
                        Text("Select a photo")
                    }
                }
            }
            
            VStack {
                Spacer()
                Button("Save") {
                    dependency.savePhoto(image: uiImage)
                    withAnimation {
                        isShowing.toggle()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemBackground))
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
