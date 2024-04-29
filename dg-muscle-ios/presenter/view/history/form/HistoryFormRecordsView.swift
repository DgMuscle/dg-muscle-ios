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
                ForEach(viewModel.records) { record in
                    HistoryFormRecordItemView(viewModel: .init(record: record,
                                                               getExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    .onTapGesture {
                        coordinator.history.recordForm(record: record, historyDateForForm: viewModel.historyDateString)
                    }
                    
                }
                .onDelete(perform: viewModel.delete)
                
            } header: {
                Text("\(viewModel.currentRecordsCount) Records, \(String(viewModel.currentTotalVolume)) Volumes")
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
            coordinator.history.recordForm(record: record, historyDateForForm: viewModel.historyDateString)
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
    let viewModel: HistoryFormRecordsViewModel = .init(history: history)
    return HistoryFormRecordsView(viewModel: viewModel,
                                  exerciseRepository: exerciseRepository)
    .preferredColorScheme(.dark)
    .environmentObject(CoordinatorV2(path: .constant(.init())))
}
