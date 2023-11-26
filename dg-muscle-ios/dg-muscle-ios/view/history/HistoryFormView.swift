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
    func tapMemo(data: ExerciseHistory)
}

struct HistoryFormView: View {
    let dependency: HistoryFormDependency
    @StateObject var notificationCenter = HistoryFormNotificationCenter.shared
    @State var history: ExerciseHistory
    @State var saveButtonDisabled: Bool
    
    var body: some View {
        VStack {
            Text("Record Form")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            List {
                ForEach(history.records) { record in
                    if let exercise = store.exercise.exercises.first(where: { $0.id ==  record.exerciseId}) {
                        recordItem(record: record, exercise: exercise)
                    } else {
                        missedRecordItem()
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach({ history.records.remove(at: $0) })
                }
                
                Button("Add", systemImage: "plus.circle") {
                    dependency.tapAdd(dateString: history.date)
                }
                
                memoSection
            }
            
            if saveButtonDisabled == false {
                Button {
                    dependency.tapSave(data: history)
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
        .onChange(of: history.records) { oldValue, newValue in
            withAnimation {
                saveButtonDisabled = newValue.filter { record in store.exercise.exercises.contains(where: { $0.id == record.exerciseId }) }.isEmpty
            }
        }
        .onChange(of: notificationCenter.record) { _, value in
            guard let value else { return }
            withAnimation {
                if let index = history.records.firstIndex(where: { $0.exerciseId == value.exerciseId }) {
                    history.records[index] = value
                } else {
                    history.records.append(value)
                }
            }
        }
        .onChange(of: notificationCenter.memo) { _, value in
            withAnimation {
                history.memo = value
            }
        }
    }
    
    var memoSection: some View {
        Section {
            Button("Memo", systemImage: "pencil.and.outline") {
                print("tap memo")
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

struct DP: HistoryFormDependency {
    func tap(record: Record, dateString: String) { }
    func tapAdd(dateString: String) { }
    func tapSave(data: ExerciseHistory) { }
    func tapMemo(data: ExerciseHistory) { }
}

#Preview {
    store.history.updateHistories()
    store.exercise.updateExercises()
    let histories = store.history.histories
    let history = histories.first!
    
    return HistoryFormView(dependency: DP(), history: history, saveButtonDisabled: false).preferredColorScheme(.dark)
}
