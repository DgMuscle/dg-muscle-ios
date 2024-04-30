//
//  ExerciseAdd2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class ExerciseAdd2ViewModel: ObservableObject {
    @Published var favorite: Bool = false
    let name: String
    let parts: [ExerciseV.Part]
    
    let postExerciseUsecase: PostExerciseUsecase
    
    init(name: String,
         parts: [ExerciseV.Part],
         postExerciseUsecase: PostExerciseUsecase) {
        self.name = name
        self.parts = parts
        self.postExerciseUsecase = postExerciseUsecase
    }
    
    func save() {
        postExerciseUsecase.implement(name: name, parts: parts.map({ ExerciseV.convertPart(part: $0) }) , isFavorite: favorite)
    }
}
