//
//  HistoryFormV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct HistoryFormV2View: View {
    
    @StateObject var viewModel: HistoryFormV2ViewModel
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        VStack(alignment: .leading) {

            HistoryCardView(dateString: viewModel.dateString,
                            duration: $viewModel.duration) {
                print("ADD HISTORY")
            } saveAction: {
                viewModel.post()
            }
            
            List {
                ForEach(viewModel.history.records) { record in
                    Button {
                        print("TAP RECORD")
                    } label: {
                        RecordListItemView(record: record, exerciseRepository: exerciseRepository)
                    }
                }
                .onDelete(perform: viewModel.onDelete)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("EXERCISE DIARY")
        .padding()
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
    
    let records: [Record] = [
        .init(id: "1", exerciseId: "squat", sets: sets),
        .init(id: "2", exerciseId: "bench press", sets: sets),
        .init(id: "3", exerciseId: "deadlift", sets: sets),
    ]
    
    let history = ExerciseHistory(id: "id", date: "20240414", memo: "Some memo.....Some memo.....Some memo.....", records: records, createdAt: nil)
    
    let viewModel: HistoryFormV2ViewModel = .init(history: history, paths: .constant(.init()), historyRepository: HistoryRepositoryV2Test())
    
    return HistoryFormV2View(viewModel: viewModel, exerciseRepository: ExerciseRepositoryV2Test()).preferredColorScheme(.dark)
}
