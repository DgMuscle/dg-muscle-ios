//
//  HistoryFormRecordItemView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import SwiftUI

struct HistoryFormRecordItemView: View {
    
    @StateObject var viewModel: HistoryFormRecordItemViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let exercise = viewModel.exercise {
                    Text("\(exercise.name)".capitalized).fontWeight(.black)
                } else {
                    VStack(alignment: .leading) {
                        Text("Error: can't find exercise".capitalized).foregroundStyle(.red).fontWeight(.bold)
                        Text("It can be happened if you delete this exercise").font(.caption)
                    }
                    
                }
                Spacer()
            }
            
            HStack {
                Text("set's count: \(viewModel.setsCount),")
                Text("volume is \(String(viewModel.volume))")
            }
            .foregroundStyle(.secondary)
            .fontWeight(.medium)
            .font(.caption)
            .padding(.top, 0)
        }
    }
}

#Preview {
    let getExerciseUsecase: GetExerciseUsecase = .init(exerciseRepository: ExerciseRepositoryTest())
    let sets: [ExerciseSetV] = [
        .init(id: UUID().uuidString, reps: 5, weight: 75),
        .init(id: UUID().uuidString, reps: 7, weight: 60),
    ]
    let record: RecordV = .init(id: "1", exerciseId: "squat", sets: sets)
    let viewModel: HistoryFormRecordItemViewModel = .init(record: record, getExerciseUsecase: getExerciseUsecase)
    return HistoryFormRecordItemView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
