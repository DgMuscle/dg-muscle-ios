//
//  RecordSectionView.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import Domain
import MockData

// ExerciseRecord

struct RecordSectionView: View {
    
    let record: ExerciseRecord
    let color: Color
    @State var expanded: Bool = false
    
    var body: some View {
        Section {
            VStack(spacing: 12) {
                HStack {
                    Text("\(record.sets.count) ").foregroundStyle(color) +
                    Text("Sets ") +
                    Text("\(record.volume) ").foregroundStyle(color) +
                    Text("Volume")
                }
                .onTapGesture {
                    expanded.toggle()
                }
                
                if expanded {
                    VStack(spacing: 12) {
                        ForEach(record.sets, id: \.self) { set in
                            Text(String(set.weight)).foregroundStyle(color) +
                            Text(" ") +
                            Text(set.unit.rawValue) +
                            Text(" ") +
                            Text("x ").fontWeight(.bold) +
                            Text("\(set.reps)").foregroundStyle(color)
                        }
                    }
                }
            }
            
        } header: {
            Text(record.exerciseName ?? "No Exercise Name")
        }
        .animation(.default, value: expanded)
    }
}

#Preview {
    
    let history = historiesFromJsonResponse[0]
    
    var record: ExerciseRecord = .init(domain: history.records[0])
    record.exerciseName = "sample exercise name"
    
    return List {
        RecordSectionView(
            record: record,
            color: .pink
        )
    }
    .preferredColorScheme(.dark)
}
