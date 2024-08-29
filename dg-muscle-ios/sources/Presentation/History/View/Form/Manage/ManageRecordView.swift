//
//  ManageRecordView.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import Foundation
import SwiftUI
import MockData
import Domain
import Common
import ExerciseTimer

public struct ManageRecordView: View {
    
    @StateObject var viewModel: ManageRecordViewModel
    @State var selectedExercise: ExerciseSet?
    @State var previousRecord: ExerciseRecord?
    
    public init(
        historyForm: Binding<HistoryForm>,
        recordId: String,
        userRepository: UserRepository,
        historyRepository: HistoryRepository,
        exerciseTimerRepository: ExerciseTimerRepository
    ) {
        _viewModel = .init(wrappedValue: .init(historyForm: historyForm,
                                               recordId: recordId, 
                                               userRepository: userRepository, 
                                               historyRepository: historyRepository, 
                                               exerciseTimerRepository: exerciseTimerRepository))
    }
    
    public var body: some View {
        List {
            
            if viewModel.traingMode == .mass, let goal = viewModel.goal {
                GoalView(goal: goal, color: viewModel.color, trainingMode: .mass)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        URLManager.shared.open(url: "dgmuscle://managetraingmode")
                    }
                    .onLongPressGesture {
                        viewModel.toggleTraningMode()
                    }
            } else if viewModel.traingMode == .strength, let goal = viewModel.strengthGoal {
                GoalView(goal: goal, color: viewModel.color, trainingMode: .strength)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        URLManager.shared.open(url: "dgmuscle://managetraingmode")
                    }
                    .onLongPressGesture {
                        viewModel.toggleTraningMode()
                    }
            }
            
            timerSelection
            setList
            newSetButton
            
        }
        .toolbar { 
            EditButton()
            if let previousRecord = viewModel.previousRecord {
                
                Button("Previous Record") {
                    self.previousRecord = previousRecord
                }
            }
        }
        .sheet(item: $selectedExercise, content: { set in
            ManageSetView(set: set, color: viewModel.color) { set in
                selectedExercise = nil
                viewModel.post(set: set)
            }
            .presentationDetents([.height(280)])
            .padding(.horizontal)
        })
        .fullScreenCover(item: $previousRecord) {
            RecordView(record: $0, color: viewModel.color) {
                self.previousRecord = nil
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if viewModel.record.sets.isEmpty {
                    selectedExercise = .init(
                        unit: .kg,
                        reps: 0,
                        weight: 0
                    )
                }
            }
        }
        .animation(.default, value: viewModel.goal)
    }
    
    var timerSelection: some View {
        HStack {
            Spacer()
            ExerciseTimer.TimeSelectionView { time in
                viewModel.selectTime(time: time)
            }
            Spacer()
        }
    }
    
    var setList: some View {
        Section {
            ForEach(viewModel.record.sets, id: \.self) { set in
                Button {
                    selectedExercise = set
                } label: {
                    HStack {
                        Text(String(set.weight)).foregroundStyle(viewModel.color) +
                        Text(" \(set.unit.rawValue)") +
                        Text(" x ").fontWeight(.heavy) +
                        Text(" \(set.reps) ").foregroundStyle(viewModel.color)
                        
                    }
                    .foregroundStyle(Color(.label))
                }
            }
            .onDelete(perform: viewModel.delete)
        } header: {
            Text("\(viewModel.currentVolume)")
        } footer: {
            if let diff = viewModel.diffWithPreviousRecord {
                Text("\(diff)").foregroundStyle(diff >= 0 ? .mint : .red)
            }
        }
    }
    
    var newSetButton: some View {
        Button("NEW SET") {
            let previousSet = viewModel.record.sets.last
            selectedExercise = .init(
                unit: previousSet?.unit ?? .kg,
                reps: previousSet?.reps ?? 0,
                weight: previousSet?.weight ?? 0
            )
        }
    }
}

#Preview {
    let history = HISTORIES[0]
    let historyForm: HistoryForm = .init(domain: history)
    
    return NavigationStack {
        ManageRecordView(
            historyForm: .constant(historyForm),
            recordId: history.records[0].id,
            userRepository: UserRepositoryMock(),
            historyRepository: HistoryRepositoryMock(),
            exerciseTimerRepository: ExerciseTimerRepositoryMockData()
        )
        .preferredColorScheme(.dark)
    }
}
