//
//  UpdateRunVelocityView.swift
//  History
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData

public struct UpdateRunVelocityView: View {
    
    @State private var velocity: Double
    
    private let updateRunVelocityUsecase: UpdateRunVelocityUsecase
    
    public init(
        runRepository: RunRepository,
        velocity: Double
    ) {
        updateRunVelocityUsecase = .init(runRepository: runRepository)
        _velocity = .init(initialValue: velocity)
    }
    
    public var body: some View {
        Text("UpdateRunVelocityView")
    }
}

#Preview {
    UpdateRunVelocityView(runRepository: RunRepositoryMock(), velocity: 6.7)
        .preferredColorScheme(.dark)
}
