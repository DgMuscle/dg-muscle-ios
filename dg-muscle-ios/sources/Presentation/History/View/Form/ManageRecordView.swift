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
    
    public init(
        historyForm: Binding<HistoryForm>,
        recordId: String,
        userRepository: UserRepository
    ) {
        _viewModel = .init(wrappedValue: .init(historyForm: historyForm,
                                               recordId: recordId, 
                                               userRepository: userRepository))
    }
    
    public var body: some View {
        List {
            Section("\(viewModel.currentVolume)") {
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
        .toolbar { EditButton() }
        .sheet(item: $selectedExercise, content: { set in
            ManageSetView(set: set, color: viewModel.color) { set in
                selectedExercise = nil
                viewModel.post(set: set)
            }
            .presentationDetents([.height(280)])
            .padding(.horizontal)
        })
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
    }
}

#Preview {
    
    let historyForm: HistoryForm = .init(domain: HISTORY_4)
    
    return ManageRecordView(
        historyForm: .constant(historyForm),
        recordId: RECORD_1.id,
        userRepository: UserRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
