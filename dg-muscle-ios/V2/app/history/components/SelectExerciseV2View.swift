//
//  SelectExerciseV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct SelectExerciseV2View: View {
    
    let exerciseRepository: ExerciseRepositoryV2
    let selectExercise: ((Exercise) -> ())?
    
    var body: some View {
        ScrollView {
            HStack {
                Text("SELECT EXERCISE")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            
            ExerciseListV2View(viewModel: .init(exerciseRepository: exerciseRepository),
                               exerciseAction: selectExercise,
                               addAction: nil,
                               deleteAction: nil)
        }
        .padding()
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let exerciseRepository: ExerciseRepositoryV2 = ExerciseRepositoryV2Test()
    
    return SelectExerciseV2View(exerciseRepository: exerciseRepository, 
                                selectExercise: nil)
        .preferredColorScheme(.dark)
}
