//
//  RemoveAccountView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import SwiftUI

struct RemoveAccountView: View {
    
    @StateObject var viewModel: RemoveAccountViewModel
    @State private var animate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            if let errorMessage = viewModel.localErrorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            Text("Please enter your display name.")
            if animate {
                Text("Once deleted, the account cannot be restored.").foregroundStyle(.red).fontWeight(.bold)
            }
            
            VStack {
                TextField("Display Name", text: $viewModel.displayName)
                    .fontWeight(.black)
                Divider()
            }
            
            HStack {
                Button {
                    viewModel.tapRemoveButton()
                } label: {
                    Text("DELETE ACCOUNT").frame(maxWidth: .infinity)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                        )
                }
            }
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                animate.toggle()
            }
        }
        .animation(.easeIn, value: animate)
        .animation(.easeIn, value: viewModel.localErrorMessage)
    }
}

#Preview {
    
    let viewModel = RemoveAccountViewModel(userRepository: UserRepositoryV2Test(),
                                           loading: .constant(false),
                                           errorMessage: .constant(nil),
                                           isPresent: .constant(true))
    
    return RemoveAccountView(viewModel: viewModel).preferredColorScheme(.dark)
}
