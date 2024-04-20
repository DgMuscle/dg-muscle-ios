//
//  ExerciseListV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListV2View: View {
    @StateObject var viewModel: ExerciseListV2ViewModel
    @State private var isAnimating: Bool = false
    
    let exerciseAction: ((Exercise) -> ())?
    let addAction: (() -> ())?
    let deleteAction: ((Exercise) -> ())?
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.sections, id: \.self) { section in
                    ExerciseListSectionV2View(part: section.part, 
                                              exercises: section.exercises,
                                              exerciseAction: exerciseAction,
                                              deleteAction: deleteAction)
                        .padding(.bottom, 8)
                }
            }
            
            if viewModel.sections.isEmpty {
                FirstExerciseButton(addAction: addAction)
            }
        }
        .drawingGroup()
    }
}

#Preview {
    
    let viewModel: ExerciseListV2ViewModel = .init(exerciseRepository: ExerciseRepositoryV2Test())
    
    return ExerciseListV2View(viewModel: viewModel,
                              exerciseAction: nil,
                              addAction: nil, 
                              deleteAction: nil)
        .preferredColorScheme(.dark)
}
