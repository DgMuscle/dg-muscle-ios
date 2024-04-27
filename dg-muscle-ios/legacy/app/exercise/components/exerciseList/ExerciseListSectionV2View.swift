//
//  ExerciseListSectionV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListSectionV2View: View {
    
    var part: Exercise.Part
    var exercises: [Exercise]
    
    let exerciseAction: ((Exercise) -> ())?
    let deleteAction: ((Exercise) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(part.rawValue.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
            .padding(.bottom, 10)
            
            VStack {
                ForEach(exercises.sorted(by: { $0.name < $1.name })) { exercise in
                    
                    Button {
                        exerciseAction?(exercise)
                    } label: {
                        ExerciseListItemView(exercise: exercise)
                    }
                    .padding(.bottom, 6)
                    .contextMenu(menuItems: {
                        if let deleteAction {
                            Button("Delete Item") {
                                deleteAction(exercise)
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

#Preview {
    return ExerciseListSectionV2View(part: .leg, 
                                     exercises: ExerciseRepositoryV2Test().exercises,
                                     exerciseAction: nil,
                                     deleteAction: nil)
        .preferredColorScheme(.dark)
}
