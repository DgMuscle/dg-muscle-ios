//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import MockData
import Domain

public struct ManageRunView: View {
    
    @StateObject var viewModel: ManageRunViewModel
    
    public init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                run: run,
                userRepository: userRepository
            )
        )
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text(String(viewModel.velocity) + " km/h")
                .font(.largeTitle)
            
            Button {
                viewModel.tapButton()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(viewModel.color.color.opacity(0.8))
                    .frame(width: 80, height: 60)
                    .overlay {
                        switch viewModel.status {
                        case .running:
                            Image(systemName: "stop.circle")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        case .notRunning:
                            Image(systemName: "play.circle")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                    }
            }
            
            RunBar(
                color: viewModel.color.color,
                percentage: viewModel.runGraphPercentage,
                startTime: viewModel.startTime,
                endTime: viewModel.endTime
            )
            
        }
        .padding()
        .animation(.default, value: viewModel.status)
    }
}

#Preview {
    ManageRunView(
        run: .constant(
            .init(
                domain: HISTORY_1.run!
            )
        ),
        userRepository: UserRepositoryMock()
    )
        .preferredColorScheme(.dark)
}
