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
    private let manageMemo: ((Binding<String>) -> ())?
    private let selectExerciseViewFactory: (((HistoryExercise) -> ())?, (() -> ())?, (() -> ())?, (() -> ())?) -> SelectExerciseView
    
    public init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository,
        history: Domain.History?,
        setRecordAction: ((Binding<HistoryForm>, String) -> ())?,
        manageRun: ((Binding<RunPresentation>) -> ())?,
        manageMemo: ((Binding<String>) -> ())?,
        selectExerciseViewFactory: @escaping (((HistoryExercise) -> ())?, (() -> ())?, (() -> ())?, (() -> ())?) -> SelectExerciseView
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
        self.manageMemo = manageMemo
        self.selectExerciseViewFactory = selectExerciseViewFactory
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
            
            ForEach($viewModel.history.memo, id: \.self) { memo in
                Section("memo") {
                    Button {
                        manageMemo?(memo)
                    } label: {
                        
                        if memo.wrappedValue.isEmpty {
                            Text("Empty")
                                .italic()
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                        } else {
                            Text(memo.wrappedValue)
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .onDelete(perform: viewModel.deleteMemo)
            
            Common.GradientButton(action: {
                isPresentSelectExercise.toggle()
            },
                                  text: "ADD RECORD",
                                  backgroundColor: viewModel.color.color)
        }
        .scrollIndicators(.hidden)
        .toolbar {
            Button {
                if viewModel.history.memo.isEmpty {
                    viewModel.history.memo.append("")
                }
                
                if let memoBinding = $viewModel.history.memo.first {
                    manageMemo?(memoBinding)
                }
                
            } label: {
                Image(systemName: "text.book.closed")
            }
            EditButton()
        }
        .fullScreenCover(isPresented: $isPresentSelectExercise, content: {
            
            selectExerciseViewFactory { exercise in
                // tap exercise
                isPresentSelectExercise.toggle()
                let recordId = viewModel.select(exercise: exercise)
                setRecordAction?($viewModel.history, recordId)
            } _: {
                // add
                isPresentSelectExercise.toggle()
                URLManager.shared.open(url: "dgmuscle://exercisemanage")
            } _: {
                // close
                isPresentSelectExercise.toggle()
            } _: {
                // run
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
    
    let selectExerciseViewFactory: (((HistoryExercise) -> ())?, (() -> ())?, (() -> ())?, (() -> ())?) -> SelectExerciseView = { tapExercise, add, close, run in
        return SelectExerciseView(
            exerciseRepository: ExerciseRepositoryMock(),
            userRepository: UserRepositoryMock(), 
            historyRepository: HistoryRepositoryMock(),
            tapExercise: tapExercise,
            add: add,
            close: close,
            run: run
        )
    }
    
    return PostHistoryView(
        historyRepository: HistoryRepositoryMock(),
        exerciseRepository: ExerciseRepositoryMock(),
        userRepository: UserRepositoryMock(),
        history: HISTORIES[0],
        setRecordAction: action,
        manageRun: nil,
        manageMemo: nil,
        selectExerciseViewFactory: selectExerciseViewFactory
    )
    .preferredColorScheme(.dark)
}
