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
            Section {
                ForEach(Common.TrainingMode.allCases, id: \.self) { mode in
                    modeView(mode: mode, selectedMode: viewModel.mode)
                        .onTapGesture {
                            viewModel.updateMode(mode: mode)
                        }
                }
            } footer: {
                Text("Select your training mode")
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
