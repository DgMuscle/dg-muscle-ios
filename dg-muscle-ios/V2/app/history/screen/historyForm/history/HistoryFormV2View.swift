//
//  HistoryFormV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct HistoryFormV2View: View {
    
    @StateObject var viewModel: HistoryFormV2ViewModel
    @Binding var paths: NavigationPath
    @State var isPresentSelectSheet: Bool = false
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        VStack(alignment: .leading) {

            HistoryCardView(dateString: viewModel.dateString,
                            duration: $viewModel.duration) {
                isPresentSelectSheet.toggle()
            } saveAction: {
                viewModel.post()
            }
            
            List {
                ForEach($viewModel.history.records) { record in
                    Button {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyyMMdd"
                        guard let date = dateFormatter.date(from: viewModel.history.date) else { return }
                        
                        paths.append(HistoryNavigation(name: .recordForm,
                                                       recordForForm: record,
                                                       dateForRecordForm: date)
                        )
                    } label: {
                        RecordListItemView(record: record, exerciseRepository: exerciseRepository)
                    }
                }
                .onDelete(perform: viewModel.onDelete)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("EXERCISE DIARY")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .sheet(isPresented: $isPresentSelectSheet, content: {
            SelectExerciseV2View(exerciseRepository: exerciseRepository) { exercise in
                addNewRecord(exercise: exercise)
            }
        })
    }
    
    private func addNewRecord(exercise: Exercise) {
        let newRecord = Record(id: UUID().uuidString,
                               exerciseId: exercise.id,
                               sets: [])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: viewModel.history.date) else { return }
        
        viewModel.history.records.append(newRecord)
        
        paths.append(HistoryNavigation(name: .recordForm,
                                       recordForForm: $viewModel.history.records.last,
                                       dateForRecordForm: date
                                      ))
        
        isPresentSelectSheet.toggle()
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
    
    return HistoryFormV2View(viewModel: viewModel, 
                             paths: .constant(.init()),
                             exerciseRepository: ExerciseRepositoryV2Test())
    .preferredColorScheme(.dark)
}
