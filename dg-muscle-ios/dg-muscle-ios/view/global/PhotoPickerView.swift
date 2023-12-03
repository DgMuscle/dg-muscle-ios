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
                    Text("Select a photo")
                }
            }
            
            VStack {
                Spacer()
                HStack(spacing: 12) {
                    if uiImage != nil {
                        Button {
                            withAnimation {
                                uiImage = nil
                                selectedItem = nil
                            }
                        } label: {
                            Text("delete")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.red)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.gray)
                                        .opacity(0.6)
                                }
                        }
                    }
                    
                    Button {
                        dependency.saveProfileImage(image: uiImage)
                        isShowing = false
                    } label: {
                        Text("save")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue)
                                    .opacity(0.6)
                            }
                    }
                }
                .padding()
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

#Preview {
    struct DP: PhotoPickerViewDependency {
        func saveProfileImage(image: UIImage?) { }
    }
    
    @State var showing = true
    
    return ZStack {
        VStack {
            Text("Hello world")
            Button("toggle") {
                withAnimation {
                    showing.toggle()
                }
            }
        }
    }
    .sheet(isPresented: $showing, content: {
        PhotoPickerView(isShowing: $showing, dependency: DP())
    })
    .preferredColorScheme(.dark)
}
