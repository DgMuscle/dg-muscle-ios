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
    @State private var isPresentSelectSheet: Bool = false
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                HistoryCardView(dateString: viewModel.dateString,
                                duration: viewModel.duration) {
                    isPresentSelectSheet.toggle()
                }
            }
            .padding(.horizontal)
            
            
            List {
                ForEach($viewModel.history.records) { record in
                    Button {
                        tapRecord(record: record)
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
        .sheet(isPresented: $isPresentSelectSheet, content: {
            SelectExerciseV2View(exerciseRepository: exerciseRepository) { exercise in
                addNewRecord(exercise: exercise)
            } addAction: {
                isPresentSelectSheet.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    addAction()
                }
            }
        })
    }
    
    private func addAction() {
        paths.append(ExerciseNavigation(name: .manage))
    }
    
    private func addNewRecord(exercise: Exercise) {
        let newRecord = Record(id: UUID().uuidString,
                               exerciseId: exercise.id,
                               sets: [])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: viewModel.history.date) else { return }
        
        viewModel.history.records.append(newRecord)
        guard let recordForForm = $viewModel.history.records.last else { return }
        
        
        let ingredient: HistoryNavigation.RecordFornIngredient =
            .init(recordForForm: recordForForm,
                  dateForRecordForm: date, 
                  startTimeInterval: viewModel.start)
        
        let navigation = HistoryNavigation(name: .recordForm,
                          recordFornIngredient: ingredient)
        
        paths.append(navigation)
        
        isPresentSelectSheet.toggle()
    }
    
    private func tapRecord(record: Binding<Record>) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: viewModel.history.date) else { return }

        let ingredient: HistoryNavigation.RecordFornIngredient =
            .init(recordForForm: record,
                  dateForRecordForm: date,
                  startTimeInterval: viewModel.start)
        
        let navigation: HistoryNavigation =
        HistoryNavigation(name: .recordForm,
                          recordFornIngredient: ingredient)
        
        paths.append(navigation)
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
    
    let viewModel: HistoryFormV2ViewModel = .init(history: history,
                                                  historyRepository: HistoryRepositoryV2Test())
    
    return HistoryFormV2View(viewModel: viewModel, 
                             paths: .constant(.init()),
                             exerciseRepository: ExerciseRepositoryV2Test())
    .preferredColorScheme(.dark)
}
