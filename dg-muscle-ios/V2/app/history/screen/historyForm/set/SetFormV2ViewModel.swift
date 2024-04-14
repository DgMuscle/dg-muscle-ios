//
//  SetFormV2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine
import SwiftUI

final class SetFormV2ViewModel: ObservableObject {
    @Published var unit: ExerciseSet.Unit
    @Published var reps: String
    @Published var weight: String
    
    @Binding var isPresenting: Bool
    
    let completeAction: ((ExerciseSet) -> ())?
    
    init(unit: ExerciseSet.Unit = .kg, 
         reps: Int = 0,
         weight: Double = 0,
         isPresenting: Binding<Bool>,
         completeAction: ((ExerciseSet) -> ())?) {
        self.unit = unit
        self.reps = String(reps)
        self.weight = String(weight)
        self._isPresenting = isPresenting
        self.completeAction = completeAction
    }
    
    func add() {
        isPresenting.toggle()
        guard let reps = Int(reps), let weight = Double(weight) else { return }
        let set = ExerciseSet(unit: unit, reps: reps, weight: weight, id: UUID().uuidString)
        completeAction?(set)
    }
}
