//
//  ExercisePartsSectionViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine
import SwiftUI

final class ExercisePartsSectionViewModel: ObservableObject {
    @Published var parts: [ExercisePartV] = ExerciseV.Part.allCases.map({ .init(part: $0) })
    @Binding var selectedParts: [ExerciseV.Part]
    
    init(parts: Binding<[ExerciseV.Part]>) {
        self._selectedParts = parts
        
        self.parts = configureParts(selectedParts: selectedParts)
    }
    
    func selected(part: ExerciseV.Part) {
        if let index = selectedParts.firstIndex(of: part) {
            selectedParts.remove(at: index)
        } else {
            selectedParts.append(part)
        }
        
        self.parts = configureParts(selectedParts: selectedParts)
    }
    
    private func configureParts(selectedParts: [ExerciseV.Part]) -> [ExercisePartV] {
        var parts: [ExercisePartV] = ExerciseV.Part.allCases.map({ .init(part: $0) })
        
        for selectedPart in selectedParts {
            if let index = parts.firstIndex(where: { $0.part == selectedPart }) {
                parts[index].selected = true
            }
        }
        
        return parts
    }
}
