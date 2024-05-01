//
//  ExercisePartsSectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExercisePartsSectionView: View {
    
    @StateObject var viewModel: ExercisePartsSectionViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.parts, id: \.self) { part in
                ExercisePartItem(part: part.part,
                                 selected: part.selected,
                                 action: viewModel.selected)

            }
        }
    }
}

#Preview {
    @State var parts: [ExerciseV.Part] = [.arm]
    let viewModel: ExercisePartsSectionViewModel = .init(parts: $parts)
    return ExercisePartsSectionView(viewModel: viewModel)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
