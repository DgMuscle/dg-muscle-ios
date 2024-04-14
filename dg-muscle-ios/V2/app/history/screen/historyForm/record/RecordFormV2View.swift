//
//  RecordFormV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct RecordFormV2View: View {
    
    @StateObject var viewModel: RecordFormV2ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let exercise = viewModel.exercise {
                HStack {
                    Text("You are currently doing \(exercise.name)")
                        .font(.title)
                        .fontWeight(.black)
                    Spacer()
                }
            }
            
            Text("Current sets count is \(viewModel.record.sets.count)")
                .fontWeight(.bold)
                .italic()
            
            Text("Current workout volume is \(Int(viewModel.record.volume))")
                .fontWeight(.bold)
                .italic()
            
            List {
                ForEach($viewModel.record.sets) { set in
                    RecordFormSetItem(set: set)
                }
                .onDelete(perform: viewModel.delete)
            }
            .scrollIndicators(.hidden)
            
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 75, id: "1"),
        .init(unit: .kg, reps: 7, weight: 75, id: "2"),
        .init(unit: .kg, reps: 6, weight: 70, id: "3"),
        .init(unit: .kg, reps: 12, weight: 60, id: "4"),
        .init(unit: .kg, reps: 8, weight: 60, id: "5"),
        .init(unit: .kg, reps: 7, weight: 60, id: "6"),
    ]
    
    let record = Record(id: "1", exerciseId: "squat", sets: sets)
    let viewModel = RecordFormV2ViewModel(record: .constant(record), exerciseRepository: ExerciseRepositoryV2Test())
    
    return RecordFormV2View(viewModel: viewModel).preferredColorScheme(.dark)
}
