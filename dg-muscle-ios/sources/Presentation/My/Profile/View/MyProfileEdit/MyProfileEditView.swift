//
//  MyProfileEditView.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI
import MockData
import Domain

public struct MyProfileEditView: View {
    
    @StateObject var viewModel: MyProfileEditViewModel
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        Text("MyProfileEditView")
    }
}

#Preview {
    MyProfileEditView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
