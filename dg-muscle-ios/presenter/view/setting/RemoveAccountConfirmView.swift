//
//  RemoveAccountConfirmView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct RemoveAccountConfirmView: View {
    
    @StateObject var viewModel: RemoveAccountConfirmViewModel
    
    let removeAccountAction: (() -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage).transition(.move(edge: .top))
            }
            
            Text("Are you sure you will delete your account?")
                .fontWeight(.heavy)
            Text("Your all data will be deleted")
                .foregroundStyle(.red)
                .font(.caption)
                .padding(.bottom)
            
            TextField("Please enter your display name", text: $viewModel.displayName)
            Divider()
            
            Button {
                viewModel.tapRemoveAccount(completion: removeAccountAction)
            } label: {
                RoundedGradationText(text: "DELETE ACCOUNT")
            }
        }
        .animation(.default, value: viewModel.errorMessage)
    }
}

#Preview {
    let viewModel: RemoveAccountConfirmViewModel = .init(getUserUsecase: .init(userRepository: UserRepositoryTest()))
    return RemoveAccountConfirmView(viewModel: viewModel,
                                    removeAccountAction: nil)
    .preferredColorScheme(.dark)
}
