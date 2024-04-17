//
//  RecordListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct RecordListItemView: View {
    
    @Binding var record: Record
    @State var exercise: Exercise? = nil
    
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        VStack(alignment: .leading) {
            if let exercise {
                HStack {
                    Text(exercise.name).font(.title2)
                    Spacer()
                    
                    Text("Tap to continue")
                        .foregroundStyle(
                            LinearGradient(colors: [Color(uiColor: .label), .secondary],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                }
                .fontWeight(.black)
                
            } else {
                BannerErrorMessageView(errorMessage: "Can't find exercise info.")
            }
            
            Text("Current Sets: \(record.sets.count)")
                .padding(.top)
            
            Text("Current Volume: \(Int(record.volume))")
        }
        .foregroundStyle(Color(uiColor: .label))
        .fontWeight(.heavy)
        .onAppear {
            exercise = exerciseRepository.exercises.first(where: { $0.id == record.exerciseId })
        }
    }
}

#Preview {
    
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 12, weight: 75, id: "1"),
        .init(unit: .kg, reps: 10, weight: 70, id: "2"),
        .init(unit: .kg, reps: 9, weight: 70, id: "3"),
        .init(unit: .kg, reps: 10, weight: 60, id: "4"),
        .init(unit: .kg, reps: 9, weight: 60, id: "5"),
    ]
    
    let record = Record(exerciseId: "squat", sets: sets)
    
    return RecordListItemView(record: .constant(record),
                              exerciseRepository: ExerciseRepositoryV2Test()
    ).preferredColorScheme(.dark)
}
