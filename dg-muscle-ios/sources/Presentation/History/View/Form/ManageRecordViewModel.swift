//
//  ManageRecordViewModel.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import Foundation
import Combine
import SwiftUI

final class ManageRecordViewModel: ObservableObject {
    @Binding var historyForm: HistoryForm
    @Published var record: ExerciseRecord
    
    private let recordId: String
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyForm: Binding<HistoryForm>,
        recordId: String
    ) {
        self._historyForm = historyForm
        self.recordId = recordId
        
        let record: ExerciseRecord = historyForm
            .wrappedValue
            .records
            .first(where: { $0.id == recordId }) ??
            .init(id: recordId)
        
        self.record = record
    }
    
    func delete(atOffsets: IndexSet) {
        record.sets.remove(atOffsets: atOffsets)
    }
}
