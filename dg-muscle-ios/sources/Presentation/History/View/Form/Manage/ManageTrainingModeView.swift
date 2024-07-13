//
//  ManageTrainingModeView.swift
//  History
//
//  Created by 신동규 on 7/13/24.
//

import SwiftUI
import Domain
import MockData

public struct ManageTrainingModeView: View {
    
    @StateObject var viewModel: ManageTrainingModeViewModel
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        Text("ManageTrainingModeView")
    }
}

#Preview {
    ManageTrainingModeView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
