//
//  ManageTrainingModeView.swift
//  History
//
//  Created by 신동규 on 7/13/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct ManageTrainingModeView: View {
    
    @StateObject var viewModel: ManageTrainingModeViewModel
    
    public init(userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        List {
            ForEach(Common.TrainingMode.allCases, id: \.self) { mode in
                Button {
                    viewModel.updateMode(mode: mode)
                } label: {
                    modeView(mode: mode, selectedMode: viewModel.mode)
                }
                .buttonStyle(.plain)
            }
        }
        .animation(.default, value: viewModel.mode)
    }
    
    func modeView(mode: Common.TrainingMode, selectedMode: Common.TrainingMode?) -> some View {
        HStack {
            Text(mode.text)
            
            if selectedMode == mode {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(viewModel.color.color)
            }
        }
    }
}

#Preview {
    ManageTrainingModeView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
