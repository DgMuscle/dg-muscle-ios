//
//  HistoryFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import SwiftUI

final class HistoryFormNotificationCenter: ObservableObject {
    static let shared = HistoryFormNotificationCenter()
    @Published var record: Record?
    @Published var memo: String?
    private init() { }
}

protocol HistoryFormDependency {
    func tap(record: Record, dateString: String)
    func tapAdd(dateString: String)
    func tapSave(data: ExerciseHistory)
    func tapMemo(memo: String?)
}

struct HistoryFormView: View {
    @StateObject var notificationCenter = HistoryFormNotificationCenter.shared
    @State var records: [Record]
    @State var memo: String?
    @State var saveButtonDisabled: Bool
    
    let dependency: HistoryFormDependency
    private let history: ExerciseHistory
    
    init(dependency: HistoryFormDependency,  history: ExerciseHistory, saveButtonDisabled: Bool) {
        self.dependency = dependency
        self.history = history
        self._records = .init(initialValue: history.records)
        self._saveButtonDisabled = .init(initialValue: saveButtonDisabled)
        self._memo = .init(initialValue: history.memo)
    }
    
    var body: some View {
        VStack {
            Text("History Form")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            List {
                ForEach(records) { record in
                    if let exercise = store.exercise.exercises.first(where: { $0.id ==  record.exerciseId}) {
                        recordItem(record: record, exercise: exercise)
                    } else {
                        missedRecordItem()
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach({ records.remove(at: $0) })
                }
                
                Button("Add", systemImage: "plus.circle") {
                    dependency.tapAdd(dateString: history.date)
                }
                
                memoSection
            }
            
            if saveButtonDisabled == false {
                Button {
                    dependency.tapSave(data: .init(id: history.id,
                                                   date: history.date,
                                                   memo: memo,
                                                   records: records,
                                                   createdAt: history.createdAt))
                } label: {
                    Text("Save")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10).fill(.blue)
                        }
                        .padding()
                }
            }
        }
        .onChange(of: records) { oldValue, newValue in
            withAnimation {
                saveButtonDisabled = newValue.filter{ record in
                    store.exercise.exercises.contains(where: { $0.id == record.exerciseId })
                }.isEmpty
            }
        }
        .onChange(of: notificationCenter.record) { _, value in
            guard let value else { return }
            withAnimation {
                if let index = records.firstIndex(where: { $0.exerciseId == value.exerciseId }) {
                    records[index] = value
                } else {
                    records.append(value)
                }
            }
        }
        .onChange(of: notificationCenter.memo) { _, value in
            withAnimation {
                memo = value
            }
        }
    }
    
    var memoSection: some View {
        Section {
            Button("Memo", systemImage: "pencil.and.outline") {
                dependency.tapMemo(memo: memo)
            }
            .font(.footnote)
            .foregroundStyle(Color(uiColor: .label))
            
            if let memo = history.memo, memo.isEmpty == false {
                Text(memo)
                    .font(.footnote)
                    .lineLimit(3)
            }
        }
    }
    
    func recordItem(record: Record, exercise: Exercise) -> some View {
        Button {
            dependency.tap(record: record, dateString: history.date)
        } label: {
            HStack {
                Text("\(exercise.name) record")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color(uiColor: .label))
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
        }
    }
    
    func missedRecordItem() -> some View {
        VStack(spacing: 4) {
            Text("This record was deleted because of absence of exercise")
                .italic()
                .foregroundStyle(.red)
            Text("(Maybe this is network issue. Please retry later.)")
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
    }
}

#Preview {
    struct DP: HistoryFormDependency {
        func tapMemo(memo: String?) { }
        func tap(record: Record, dateString: String) { }
        func tapAdd(dateString: String) { }
        func tapSave(data: ExerciseHistory) { }
    }
    
    store.history.updateHistories()
    store.exercise.updateExercises()
    let histories = store.history.histories
    let history = histories.first!
    
    return VStack {
        Button("record add button") {
            let record: Record = .init(id: "1", exerciseId: "shoulder press", sets: [.init(unit: .kg, reps: 12, weight: 50)])
            let record2: Record = .init(id: "2", exerciseId: "squat", sets: [.init(unit: .kg, reps: 12, weight: 50)])
            let record3: Record = .init(id: "3", exerciseId: "babel row", sets: [.init(unit: .kg, reps: 12, weight: 50)])
            if Bool.random() {
                HistoryFormNotificationCenter.shared.record = record
            } else {
                if Bool.random() {
                    HistoryFormNotificationCenter.shared.record = record2
                } else {
                    HistoryFormNotificationCenter.shared.record = record3
                }
            }
            
        }
        HistoryFormView(dependency: DP(), history: history, saveButtonDisabled: false).preferredColorScheme(.dark)
    }
}
