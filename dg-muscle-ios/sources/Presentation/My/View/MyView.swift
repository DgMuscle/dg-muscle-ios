//
//  MyView.swift
//  My
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher

struct MyView: View {
    @StateObject var viewModel: MyViewModel
    
    init(userRepository: any UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    var body: some View {
        List {
            Section {
                Text("My")
            } header: {
                HStack {
                    if let url = viewModel.user?.photoURL {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                    
                    Text(viewModel.user?.displayName ?? "Display Name")
                    
                    Spacer()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return MyView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
