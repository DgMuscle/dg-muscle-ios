//
//  RapidExerciseDetailView.swift
//  Rapid
//
//  Created by 신동규 on 7/26/24.
//

import SwiftUI
import Domain
import MockData

public struct RapidExerciseDetailView: View {
    
    let data: RapidExercisePresentation
    
    public init(exercise: Domain.RapidExerciseDomain) {
        data = .init(domain: exercise)
    }
    
    public var body: some View {
        Text("RapidExerciseDetailView")
    }
}

#Preview {
    
    let repository = RapidRepositoryMock()
    
    
    return RapidExerciseDetailView(exercise: repository.get()[0])
        .preferredColorScheme(.dark)
}
