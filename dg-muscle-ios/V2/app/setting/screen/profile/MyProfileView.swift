//
//  MyProfileView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import SwiftUI

struct MyProfileView: View {
    
    @StateObject var viewModel: MyProfileViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    let viewModel: MyProfileViewModel = .init(userRepository: UserRepositoryV2Test(),
                                              healthRepository: HealthRepositoryTest())
    
    return MyProfileView(viewModel: viewModel).preferredColorScheme(.dark)
}
