//
//  ManageExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ManageExerciseView: View {
    
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        ScrollView {
            ExerciseListV2View(viewModel: .init(exerciseRepository: exerciseRepository)) { exercise in
                print("tap exercise \(exercise.name)")
            } addAction: {
                print("tap add button")
            }
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("tap add button")
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    return ManageExerciseView(exerciseRepository: ExerciseRepositoryV2Test())
        .preferredColorScheme(.dark)
}
