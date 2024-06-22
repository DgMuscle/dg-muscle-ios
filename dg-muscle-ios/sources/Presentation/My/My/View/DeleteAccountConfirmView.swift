//
//  DeleteAccountConfirmView.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct DeleteAccountConfirmView: View {
    
    private let deleteAccountTriggerUsecase: DeleteAccountTriggerUsecase
    
    public init(userRepository: UserRepository) {
        deleteAccountTriggerUsecase = .init(userRepository: userRepository)
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Are you really want to delete your account?")
                    Spacer()
                }
                
                Text("This cannot be reversed.")
                    .italic()
                    .foregroundStyle(.red)
                
            }
            
            VStack {
                Spacer()
                Common.GradientButton(action: {
                    URLManager.shared.open(url: "dgmuscle://pop")
                    deleteAccountTriggerUsecase.implement()
                }, text: "DELETE", backgroundColor: .red)
            }
        }
        .padding()
    }
}

#Preview {
    DeleteAccountConfirmView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
