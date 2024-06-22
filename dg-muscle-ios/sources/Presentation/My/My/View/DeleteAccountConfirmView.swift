//
//  DeleteAccountConfirmView.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData

public struct DeleteAccountConfirmView: View {
    
    private let deleteAccountTriggerUsecase: DeleteAccountTriggerUsecase
    
    public init(userRepository: UserRepository) {
        deleteAccountTriggerUsecase = .init(userRepository: userRepository)
    }
    
    public var body: some View {
        Text("DeleteAccountConfirmView")
    }
}

#Preview {
    DeleteAccountConfirmView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
