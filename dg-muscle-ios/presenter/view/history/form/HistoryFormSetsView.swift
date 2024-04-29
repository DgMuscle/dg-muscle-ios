//
//  HistoryFormSetsView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import SwiftUI

struct HistoryFormSetsView: View {
    
    @StateObject var viewModel: HistoryFormSetsViewModel
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.sets) { set in
                    HistoryFormSetItemView(set: set)
                }
                .onDelete(perform: viewModel.delete)
            } footer: {
                
                VStack {
                    HStack {
                        Text("\(viewModel.currentSetsCount) sets,")
                        Text("\(String(viewModel.currentRecordVolume)) volumes")
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    RoundedGradationText(text: "NEW SET")
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.exercise?.name ?? "Error: Can't find exercise".capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sets: [ExerciseSetV] = [
        .init(id: UUID().uuidString, reps: 10, weight: 70),
        .init(id: UUID().uuidString, reps: 4, weight: 70),
        .init(id: UUID().uuidString, reps: 8, weight: 60),
    ]
    let record: RecordV = .init(id: UUID().uuidString, exerciseId: "squat", sets: sets)
    let viewModel: HistoryFormSetsViewModel = .init(record: .constant(record),
                                                    historyDateString: "20240429",
                                                    getPreviousRecordUsecase: .init(historyRepository: HistoryRepositoryTest()),
                                                    getExerciseUsecase: .init(exerciseRepository: ExerciseRepositoryTest()))
    return HistoryFormSetsView(viewModel: viewModel)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
