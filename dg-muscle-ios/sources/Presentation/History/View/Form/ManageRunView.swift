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
    @State var animate: Bool = false
    
    public init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository,
        runRepository: RunRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                run: run,
                userRepository: userRepository, 
                runRepository: runRepository
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
                .opacity(animate && viewModel.velocity == 0 ? 0.4 : 1)
                .onTapGesture {
                    URLManager.shared.open(url: "dgmuscle://updaterunvelocity?velocity=\(viewModel.velocity)")
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
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    var run: RunPresentation = .init(domain: HISTORY_1.run!)
    
    if let index = run.pieces.indices.last {
        run.pieces[index].velocity = 0
    }
    
    return ManageRunView(
        run: .constant(
            run
        ),
        userRepository: UserRepositoryMock(),
        runRepository: RunRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
