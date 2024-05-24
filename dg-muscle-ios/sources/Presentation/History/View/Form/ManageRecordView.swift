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
    @State var selectedSet: ExerciseSet?
    @State var isPresentSetSheet: Bool = false
    
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
                        selectedSet = set
                        isPresentSetSheet.toggle()
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
            
            Common.GradientButton(action: {
                
                let previousSet = viewModel.record.sets.last
                
                selectedSet = .init(
                    unit: previousSet?.unit ?? .kg,
                    reps: previousSet?.reps ?? 0,
                    weight: previousSet?.weight ?? 0
                )
                isPresentSetSheet.toggle()
            },
                                  text: "NEW",
                                  backgroundColor: viewModel.color)
            
        }
        .toolbar { EditButton() }
        .sheet(isPresented: $isPresentSetSheet) {
            ManageSetView(
                set: selectedSet ?? .init(unit: .kg, reps: 0, weight: 0),
                color: viewModel.color) { set in
                    isPresentSetSheet.toggle()
                    viewModel.post(set: set)
                }
                .presentationDetents([.height(280)])
                .padding(.horizontal)
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
