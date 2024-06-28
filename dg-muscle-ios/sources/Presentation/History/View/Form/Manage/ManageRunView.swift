//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/26/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct ManageRunView: View {
    
    @StateObject var viewModel: ManageRunViewModel
    private let spacing: CGFloat = 12
    
    public init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository,
        historyRepository: HistoryRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                run: run,
                userRepository: userRepository,
                historyRepository: historyRepository
            )
        )
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            
            if viewModel.runBarPercentage != 0 {
                GeometryReader { geometry in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [viewModel.color.opacity(0.4), viewModel.color.opacity(0.9)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: max(0, geometry.size.width * viewModel.runBarPercentage - 30))
                            .overlay {
                                HStack {
                                    Spacer()
                                    Text(viewModel.averageVelocityText)
                                        .font(.caption2)
                                        .padding(.trailing)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                }
                            }
                        Image(systemName: "figure.run")
                    }
                }
                .frame(height: 30)
                .animation(.linear(duration: 0.5), value: viewModel.runBarPercentage)
            }
            
            HStack {
                Text("Distance: ")
                Button {
                    URLManager.shared.open(url: "dgmuscle://setrundistance?distance=\(viewModel.distance)")
                } label: {
                    Text(viewModel.distanceText)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .tertiarySystemBackground))
                        )
                }
                Spacer()
            }
            
            HStack {
                Text("Duration: ")
                Button {
                    URLManager.shared.open(url: "dgmuscle://setrunduration?duration=\(viewModel.duration)")
                } label: {
                    Text(viewModel.durationText)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .tertiarySystemBackground))
                        )
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let run = HISTORY_1.run!
    let view = ManageRunView(
        run: .constant(
            .init(
                domain: run
            )
        ),
        userRepository: UserRepositoryMock(),
        historyRepository: HistoryRepositoryMock()
    )
    return view
        .preferredColorScheme(.dark)
}
