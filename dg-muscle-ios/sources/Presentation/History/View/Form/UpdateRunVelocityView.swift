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
    
    private let updateRunVelocityUsecase: UpdateRunVelocityUsecase
    
    public init(runRepository: RunRepository) {
        updateRunVelocityUsecase = .init(runRepository: runRepository)
    }
    
    public var body: some View {
        Text("UpdateRunVelocityView")
    }
}

#Preview {
    UpdateRunVelocityView(runRepository: RunRepositoryMock())
        .preferredColorScheme(.dark)
}
