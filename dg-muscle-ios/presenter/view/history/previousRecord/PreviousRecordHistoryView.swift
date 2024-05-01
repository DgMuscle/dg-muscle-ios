//
//  PreviousRecordHistoryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import SwiftUI

struct PreviousRecordHistoryView: View {
    @StateObject var viewModel: PreviousRecordHistoryViewModel
    var body: some View {
        List {
            Section {
                ForEach(viewModel.sets) { set in
                    HStack {
                        Text("\(Int(set.weight))\(set.unit.rawValue) x \(set.reps)")
                        Text("(\(Int(set.volume)))")
                    }
                }
            } header: {
                Text("\(viewModel.dateString), \(viewModel.exerciseName)")
            } footer: {
                Text("\(viewModel.setsCount) sets, \(viewModel.volume) volume")
            }
        }
    }
}

#Preview {
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let history = historyRepository.histories.randomElement()!
    let record = history.records.randomElement()!
    let viewModel: PreviousRecordHistoryViewModel = .init(record: .init(from: record),
                                                          date: Date(),
                                                          getExerciseUsecase: .init(exerciseRepository: ExerciseRepositoryTest()))
    return PreviousRecordHistoryView(viewModel: viewModel).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
