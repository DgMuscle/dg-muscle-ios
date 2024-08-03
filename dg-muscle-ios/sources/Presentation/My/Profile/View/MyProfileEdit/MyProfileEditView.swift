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
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                topSection
                
                Spacer()
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
            Text("Cancel")
            
            Spacer()
            
            Text("Done")
        }
        .padding(.horizontal)
    }
}

#Preview {
    MyProfileEditView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
