//
//  ExerciseSectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseSectionView: View {
    
    var section: ExerciseSectionV
    
    let tapExercise: ((ExerciseV) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(section.part.rawValue.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom, 10)
            
            VStack {
                ForEach(section.exercises.sorted(by: { $0.name < $1.name })) { exercise in
                    
                    Button {
                        tapExercise?(exercise)
                    } label: {
                        ExerciseItemView(exercise: exercise)
                    }
                    .padding(.bottom, 6)
                    .contextMenu(menuItems: {
                        if let tapExercise {
                            Button("Delete Item") {
                                tapExercise(exercise)
                            }
                        }
                    })
                }
            }
            .padding(.leading, 12)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
    }
}
