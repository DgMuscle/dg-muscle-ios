//
//  ExercisePartsSelectionForm.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExercisePartsSelectionForm: View {
    
    @StateObject var viewModel: ExercisePartsSelectionFormModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.parts, id: \.self) { part in
                ExercisePartSelectionItem(part: part.part, selected: part.selected) { part in
                    viewModel.selected(part: part)
                }
            }
        }
    }
}

#Preview {
    
    @State var parts: [Exercise.Part] = [.leg, .chest]
    
    return ExercisePartsSelectionForm(viewModel: .init(parts: $parts))
        .preferredColorScheme(.dark)
}
