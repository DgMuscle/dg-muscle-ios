//
//  PostHistoryView.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import SwiftUI
import Domain
import MockData
import Common
import MapKit

public struct PostHistoryView: View {
    
    @StateObject var viewModel: PostHistoryViewModel
    @State var isPresentSelectExercise: Bool = false
    private let exerciseRepository: ExerciseRepository
    private let setRecordAction: ((Binding<HistoryForm>, String) -> ())?
    private let manageRun: ((Binding<RunPresentation>) -> ())?
    
    public init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository,
        history: Domain.History?,
        setRecordAction: ((Binding<HistoryForm>, String) -> ())?,
        manageRun: ((Binding<RunPresentation>) -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                history: history,
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                userRepository: userRepository
            )
        )
        self.setRecordAction = setRecordAction
        self.exerciseRepository = exerciseRepository
        self.manageRun = manageRun
    }
    
    public var body: some View {
        List {
            ForEach(viewModel.history.records, id: \.self) { record in
                Section(record.exerciseName ?? "CAN'T FIND THE EXERCISE") {
                    Button {
                        setRecordAction?($viewModel.history, record.id)
                    } label: {
                        HStack {
                            Text("\(record.sets.count) ").foregroundStyle(viewModel.color.color) +
                            Text("Sets ") +
                            Text("\(record.volume) ").foregroundStyle(viewModel.color.color) +
                            Text("Volume")
                        }
                        .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            .onDelete(perform: viewModel.delete)
            
            ForEach($viewModel.history.run, id: \.self) { run in
                Section("RUN") {
                    Button {
                        manageRun?(run)
                    } label: {
                        Text(MKDistanceFormatter().string(fromDistance: run.wrappedValue.distance))
                    }
                }
            }
            .onDelete(perform: viewModel.deleteRun)
            
            Common.GradientButton(action: {
                isPresentSelectExercise.toggle()
            },
                                  text: "ADD RECORD",
                                  backgroundColor: viewModel.color.color)
        }
        .scrollIndicators(.hidden)
        .toolbar { EditButton() }
        .fullScreenCover(isPresented: $isPresentSelectExercise, content: {
            SelectExerciseView(exerciseRepository: exerciseRepository) { exercise in
                isPresentSelectExercise.toggle()
                let recordId = viewModel.select(exercise: exercise)
                setRecordAction?($viewModel.history, recordId)
            } add: {
                isPresentSelectExercise.toggle()
                URLManager.shared.open(url: "dgmuscle://exercisemanage")
            } close: {
                isPresentSelectExercise.toggle()
            } run: {
                isPresentSelectExercise.toggle()
                
                if let run = $viewModel.history.run.first {
                    manageRun?(run)
                } else {
                    viewModel.history.run = [.init()]
                    if let run = $viewModel.history.run.first {
                        manageRun?(run)
                    }
                }
            }
        })
    }
}

#Preview {
    
    func action(historyForm: Binding<HistoryForm>, recordId: String) {
        print(recordId)
    }
    
    return PostHistoryView(
        historyRepository: HistoryRepositoryMock(),
        exerciseRepository: ExerciseRepositoryMock(),
        userRepository: UserRepositoryMock(),
        history: HISTORY_4,
        setRecordAction: action,
        manageRun: nil
    )
    .preferredColorScheme(.dark)
}
