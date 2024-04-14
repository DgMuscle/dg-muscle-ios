//
//  ManageExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ManageExerciseView: View {
    
    let exerciseRepository: ExerciseRepositoryV2
    @Binding var paths: [NavigationPath]
    
    var body: some View {
        ScrollView {
            ExerciseListV2View(viewModel: .init(exerciseRepository: exerciseRepository)) { exercise in
                print("tap exercise \(exercise.name)")
            } addAction: {
                paths.append(.exerciseFormStep)
            } deleteAction: { exercise in
                print("delete exercise \(exercise)")
            }
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    paths.append(.exerciseFormStep)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    return ManageExerciseView(exerciseRepository: ExerciseRepositoryV2Test(), paths: .constant([]))
        .preferredColorScheme(.dark)
}
