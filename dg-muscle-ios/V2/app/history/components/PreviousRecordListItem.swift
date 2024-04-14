//
//  PreviousRecordListItem.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct PreviousRecordListItem: View {
    
    @State var exercise: ExerciseSet
    
    var body: some View {
        VStack {
            HStack {
                Text("Weight is")
                    .fontWeight(.black).italic()
                Text("\(Int(exercise.weight))").fontWeight(.heavy)
                Text(exercise.unit.rawValue).fontWeight(.heavy)
                Spacer()
            }
            
            HStack {
                Text("\(exercise.reps)")
                    .fontWeight(.black).italic()
                Text("reps").fontWeight(.heavy)
                Spacer()
            }
        }
    }
}

#Preview {
    
    return PreviousRecordListItem(exercise: .init(unit: .kg, reps: 10, weight: 75, id: "1"))
        .preferredColorScheme(.dark)
}
