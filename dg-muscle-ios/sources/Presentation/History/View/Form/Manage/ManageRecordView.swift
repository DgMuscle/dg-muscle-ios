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

public struct ManageRecordView: View {
    
    @StateObject var viewModel: ManageRecordViewModel
    @State var selectedExercise: ExerciseSet?
    @State var previousRecord: ExerciseRecord?
    
    public init(
        historyForm: Binding<HistoryForm>,
        recordId: String,
        userRepository: UserRepository,
        historyRepository: HistoryRepository
    ) {
        _viewModel = .init(wrappedValue: .init(historyForm: historyForm,
                                               recordId: recordId, 
                                               userRepository: userRepository, 
                                               historyRepository: historyRepository))
    }
    
    public var body: some View {
        List {
            
            if let goal = viewModel.goal {
                GoalView(goal: goal, color: viewModel.color)
            }
            
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
            
            Button("NEW SET") {
                let previousSet = viewModel.record.sets.last
                selectedExercise = .init(
                    unit: previousSet?.unit ?? .kg,
                    reps: previousSet?.reps ?? 0,
                    weight: previousSet?.weight ?? 0
                )
            }
            
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
}

#Preview {
    
    let historyForm: HistoryForm = .init(domain: HISTORY_1)
    
    return NavigationStack {
        ManageRecordView(
            historyForm: .constant(historyForm),
            recordId: RECORD_1.id,
            userRepository: UserRepositoryMock(),
            historyRepository: HistoryRepositoryMock()
        )
        .preferredColorScheme(.dark)
    }
}
