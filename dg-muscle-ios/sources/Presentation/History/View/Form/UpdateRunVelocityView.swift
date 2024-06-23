//
//  UpdateRunVelocityView.swift
//  History
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct UpdateRunVelocityView: View {
    
    @State private var velocity: Double
    @FocusState private var focus
    let color: Common.HeatMapColor
    
    private let updateRunVelocityUsecase: UpdateRunVelocityUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }

    public init(
        runRepository: RunRepository,
        userRepository: UserRepository,
        velocity: Double
    ) {
        updateRunVelocityUsecase = .init(runRepository: runRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        _velocity = .init(initialValue: velocity)
        color = .init(domain: getHeatMapColorUsecase.implement())
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                TextField("Velocity", value: $velocity, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
                    .fontWeight(.black)
                    .font(.system(size: 40))
                    .focused($focus)
                Text("km/h")
                Spacer()
            }
            
            Common.GradientButton(action: {
                updateRunVelocityUsecase.implement(velocity: velocity)
                URLManager.shared.open(url: "dgmuscle://pop")
            }, text: "SAVE", backgroundColor: color.color)
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focus.toggle()
            }
        }
    }
}

#Preview {
    UpdateRunVelocityView(
        runRepository: RunRepositoryMock(),
        userRepository: UserRepositoryMock(),
        velocity: 6.72
    )
    .preferredColorScheme(.dark)
}
