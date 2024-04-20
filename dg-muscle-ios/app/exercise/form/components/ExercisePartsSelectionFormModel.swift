//
//  ExercisePartsSelectionFormModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine
import SwiftUI

final class ExercisePartsSelectionFormModel: ObservableObject {
    @Published var parts: [Part] = Exercise.Part.allCases.map({ .init(part: $0) })
    @Binding private var selectedParts: [Exercise.Part]
    
    init(parts: Binding<[Exercise.Part]>) {
        self._selectedParts = parts
        
        self.parts = configureParts(selectedParts: selectedParts)
    }
    
    func selected(part: Exercise.Part) {
        if let index = selectedParts.firstIndex(of: part) {
            selectedParts.remove(at: index)
        } else {
            selectedParts.append(part)
        }
        
        self.parts = configureParts(selectedParts: selectedParts)
    }
    
    private func configureParts(selectedParts: [Exercise.Part]) -> [Part] {
        var parts: [Part] = Exercise.Part.allCases.map({ .init(part: $0) })
        
        for selectedPart in selectedParts {
            if let index = parts.firstIndex(where: { $0.part == selectedPart }) {
                parts[index].selected = true
            }
        }
        
        return parts
    }
}

extension ExercisePartsSelectionFormModel {
    struct Part: Hashable {
        let part: Exercise.Part
        var selected: Bool = false
    }
}
