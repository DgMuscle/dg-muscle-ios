//
//  HistoryFormRecordsView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct HistoryFormRecordsView: View {
    
    @StateObject var viewModel: HistoryFormRecordsViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    @State private var isPresentSelectExercise: Bool = false
    
    let exerciseRepository: ExerciseRepository
    
    var body: some View {
        List {
            Section {
                ForEach($viewModel.records, id: \.self) { record in
                    HistoryFormRecordItemView(viewModel: .init(record: record.wrappedValue,
                                                               getExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    .onTapGesture {
                        coordinator.history.recordForm(record: record, historyDateForForm: viewModel.history.date)
                    }
                    
                }
                .onDelete(perform: viewModel.delete)
                
            } header: {
                Text("\(viewModel.currentRecordsCount) Records, \(String(viewModel.currentTotalVolume)) Volume")
            } footer: {
                Button {
                    isPresentSelectExercise.toggle()
                } label: {
                    RoundedGradationText(text: "NEW RECORD")
                }
                .padding(.top)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.title)
        .fullScreenCover(isPresented: $isPresentSelectExercise) {
            ExerciseSelectView(exerciseRepository: exerciseRepository,
                               select: select,
                               moveToExerciseManage: moveToExerciseManage)
        }
    }
    
    private func select(exercise: ExerciseV) {
        isPresentSelectExercise.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let record: RecordV = .init(id: UUID().uuidString, exerciseId: exercise.id, sets: [])
            viewModel.records.append(record)
            guard let record = $viewModel.records.last else { return }
            coordinator.history.recordForm(record: record, historyDateForForm: viewModel.history.date)
        }
    }
    
    private func moveToExerciseManage() {
        isPresentSelectExercise.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            coordinator.exercise.manage()
        }
    }
}

#Preview {
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let history: HistoryV = .init(from: HistoryRepositoryTest().histories.randomElement()!)
    let viewModel: HistoryFormRecordsViewModel = .init(history: history, 
                                                       postHistoryUsecase: .init(historyRepository: HistoryRepositoryTest()))
    return HistoryFormRecordsView(viewModel: viewModel,
                                  exerciseRepository: exerciseRepository)
    .preferredColorScheme(.dark)
    .environmentObject(CoordinatorV2(path: .constant(.init())))
}