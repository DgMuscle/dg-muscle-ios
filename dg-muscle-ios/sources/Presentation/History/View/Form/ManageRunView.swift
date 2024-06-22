//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import MockData
import Domain
import Common

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
            
            if let status = viewModel.statusView {
                Common.StatusView(status: status)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.statusView = nil
                        }
                    }
            }
            
            Text(String(viewModel.velocity) + " km/h")
                .font(.largeTitle)
                .fontWeight(.black)
                .onTapGesture {
                    URLManager.shared.open(url: "dgmuscle://updaterunvelocity")
                }
            
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
                endTime: viewModel.endTime,
                distance: viewModel.distance
            )
            
            if viewModel.runPieces.isEmpty == false {
                VelocityChartView(data: viewModel.runPieces)
            }
            
        }
        .padding()
        .animation(.default, value: viewModel.status)
        .animation(.default, value: viewModel.statusView)
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
