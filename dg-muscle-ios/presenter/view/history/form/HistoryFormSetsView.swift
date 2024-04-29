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
                        .onTapGesture {
                            viewModel.tapSet(set: set)
                        }
                }
                .onDelete(perform: viewModel.delete)
            } header: {
                VStack(alignment: .leading) {
                    if let previousRecord = viewModel.previousRecord {
                        Button {
                            print("move to previous record page")
                        } label: {
                            HStack {
                                Text("previous record")
                                Image(systemName: "doc")
                            }
                        }
                    }
                    
                    HStack {
                        if let previousRecordVolume = viewModel.previousRecordVolume {
                            Text("\(String(previousRecordVolume)) volumes")
                        }
                        
                        if let diffWithPrevious = viewModel.diffWithPrevious {
                            Text("\(String(abs(diffWithPrevious)))")
                                .foregroundStyle(diffWithPrevious >= 0 ? .green : .red)
                        }
                    }
                }
                
            } footer: {
                VStack {
                    HStack {
                        Text("\(viewModel.currentSetsCount) sets,")
                        Text("\(String(viewModel.currentRecordVolume)) volumes")
                        Spacer()
                    }
                    .padding(.bottom)
                    Button {
                        viewModel.newSet()
                    } label: {
                        RoundedGradationText(text: "NEW SET")
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.exercise?.name ?? "Error: Can't find exercise".capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.present.isPresent) {
            let set = viewModel.present.set ?? .init(id: UUID().uuidString, reps: 0, weight: 0)
            HistoryFormSetView(viewModel: .init(set: set), save: viewModel.post)
                .presentationDetents([.height(200)])
        }
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
        .preferredColorScheme(.dark)
}
