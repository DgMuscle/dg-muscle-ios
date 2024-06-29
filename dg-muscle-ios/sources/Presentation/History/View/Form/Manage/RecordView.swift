//
//  RecordView.swift
//  History
//
//  Created by 신동규 on 5/29/24.
//

import SwiftUI
import MockData

struct RecordView: View {
    
    let record: ExerciseRecord
    let color: Color
    let closeAction: (() -> ())?
    
    var body: some View {
        List {
            
            HStack {
                Button("Close") {
                    closeAction?()
                }
            }
            
            Section("\(record.volume)") {
                ForEach(record.sets, id: \.self) { set in
                    HStack {
                        Text(String(set.weight)).foregroundStyle(color) +
                        Text(" \(set.unit.rawValue)") +
                        Text(" x ").fontWeight(.heavy) +
                        Text(" \(set.reps) ").foregroundStyle(color)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    RecordView(
        record: .init(domain: RECORD_1),
        color: .mint,
        closeAction: nil
    )
        .preferredColorScheme(.dark)
}
