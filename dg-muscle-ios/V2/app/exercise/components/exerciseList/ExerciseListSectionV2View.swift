//
//  ExerciseListSectionV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListSectionV2View: View {
    
    @State var part: Exercise.Part
    @State var exercises: [Exercise]
    
    let exerciseAction: ((Exercise) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(part.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .italic()
                
                Spacer()
            }
            .padding(.bottom, 10)
            
            VStack {
                ForEach(exercises.sorted(by: { $0.name < $1.name })) { exercise in
                    
                    Button {
                        exerciseAction?(exercise)
                    } label: {
                        ExerciseListItemView(exercise: exercise)
                            .padding(.bottom, 6)
                    }
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
                                     exerciseAction: nil)
        .preferredColorScheme(.dark)
}
