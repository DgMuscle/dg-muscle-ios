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
    let addAction: (() -> ())?
    
    var body: some View {
        ScrollView {
            HStack {
                Text("SELECT EXERCISE")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            
            Button {
                addAction?()
            } label: {
                HStack {
                    Text("Move to Exercise Manager")
                    Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath")
                    Spacer()
                }
                .fontWeight(.black)
                .padding(.bottom)
                .foregroundStyle(
                    LinearGradient(colors: [.pink, .yellow], startPoint: .leading, endPoint: .trailing)
                )
            }
            
            ExerciseListV2View(viewModel: .init(exerciseRepository: exerciseRepository),
                               exerciseAction: selectExercise,
                               addAction: addAction,
                               deleteAction: nil)
        }
        .padding()
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let exerciseRepository: ExerciseRepositoryV2 = ExerciseRepositoryV2Test()
    
    // Empty exercise
    let exerciseRepository2: ExerciseRepositoryV2 = ExerciseRepositoryV3Test()
    
    return SelectExerciseV2View(exerciseRepository: exerciseRepository,
                                selectExercise: nil,
                                addAction: nil)
    .preferredColorScheme(.dark)
        
}
