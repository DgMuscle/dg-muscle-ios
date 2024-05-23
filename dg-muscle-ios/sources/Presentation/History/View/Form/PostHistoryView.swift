//
//  PostHistoryView.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import SwiftUI
import Domain
import MockData

public struct PostHistoryView: View {
    
    @StateObject var viewModel: PostHistoryViewModel
    private let tapRecordAction: ((Binding<ExerciseRecord>) -> ())?
    
    public init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        history: Domain.History?,
        tapRecordAction: ((Binding<ExerciseRecord>) -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                historyRepository: historyRepository, 
                exerciseRepository: exerciseRepository,
                history: history
            )
        )
        self.tapRecordAction = tapRecordAction
    }
    
    public var body: some View {
        List {
            ForEach($viewModel.history.records, id: \.self) { record in
                let binding = record
                let record = record.wrappedValue
                Section(record.exerciseName ?? "CAN'T FIND THE EXERCISE") {
                    
                    Button {
                        tapRecordAction?(binding)
                    } label: {
                        HStack {
                            Text("\(record.sets.count) ").foregroundStyle(.blue) +
                            Text("Sets ") +
                            Text("\(record.volume) ").foregroundStyle(.blue) +
                            Text("Volume")
                        }
                        .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .scrollIndicators(.hidden)
        .toolbar { EditButton() }
    }
}

#Preview {
    
    func action(record: Binding<ExerciseRecord>) {
        print(record)
    }
    
    return PostHistoryView(
        historyRepository: HistoryRepositoryMock(),
        exerciseRepository: ExerciseRepositoryMock(),
        history: HISTORY_4,
        tapRecordAction: action
    )
    .preferredColorScheme(.dark)
}
