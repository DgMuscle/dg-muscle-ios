//
//  PreviousRecordView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct PreviousRecordView: View {
    
    @State var viewModel: PreviousRecordViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "calendar")
                    Text(viewModel.dateString)
                }
                .fontWeight(.black)
                
                
                if let exercise = viewModel.exercise {
                    HStack {
                        Text("Your last '\(exercise.name)' record like below")
                        Spacer()
                    }
                    .font(.title)
                    .fontWeight(.black)
                }
                
                VStack(alignment: .leading) {
                    Text("Sets count is \(viewModel.record.sets.count)")
                        .fontWeight(.bold)
                        .italic()
                    
                    Text("Workout volume are \(Int(viewModel.record.volume))")
                        .fontWeight(.bold)
                        .italic()
                }
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .secondarySystemBackground))
                )
                
                
                Spacer(minLength: 20)
                
                ForEach(viewModel.record.sets) { set in
                    PreviousRecordListItem(exercise: set)
                        .padding(.bottom)
                }
                
                
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 75, id: "1"),
        .init(unit: .kg, reps: 8, weight: 75, id: "2"),
        .init(unit: .kg, reps: 12, weight: 60, id: "3"),
        .init(unit: .kg, reps: 10, weight: 60, id: "4"),
        .init(unit: .kg, reps: 10, weight: 60, id: "5"),
    ]
    
    let record: Record = .init(id: "1", exerciseId: "squat", sets: sets)
    
    let viewModel: PreviousRecordViewModel = .init(record: record,
                                                   date: Date(),
                                                   exerciseRepository: ExerciseRepositoryV2Test())
    
    return PreviousRecordView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
