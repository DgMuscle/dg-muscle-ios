//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/26/24.
//

import SwiftUI
import Domain
import MockData

public struct ManageRunView: View {
    
    @StateObject var viewModel: ManageRunViewModel
    private let spacing: CGFloat = 12
    
    public init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository
    ) {
        _viewModel = .init(wrappedValue: .init(run: run, userRepository: userRepository))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            
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
                        .frame(width: geometry.size.width * viewModel.runBarPercentage - 30)
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
            
            HStack {
                Text("Distance: ")
                Button {
                    print("tap distance")
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
                    print("tap duration")
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
        userRepository: UserRepositoryMock()
    )
    return view
        .preferredColorScheme(.dark)
}
