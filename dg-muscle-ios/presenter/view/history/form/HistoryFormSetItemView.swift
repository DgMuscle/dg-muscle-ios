//
//  HistoryFormSetItemView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import SwiftUI

struct HistoryFormSetItemView: View {
    
    let set: ExerciseSetV
    
    var body: some View {
        HStack {
            Text("\(String(set.weight))\(set.unit.rawValue) x \(set.reps) (\(String(set.volume)))")
                .fontWeight(.bold)
            Spacer()
        }
    }
}

#Preview {
    let set: ExerciseSetV = .init(id: UUID().uuidString, reps: 12, weight: 65)
    return HistoryFormSetItemView(set: set)
        .preferredColorScheme(.dark)
}
