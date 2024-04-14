//
//  FullRecordsView_SetView.swift
//  dg-muscle-workspace
//
//  Created by 신동규 on 3/1/24.
//

import SwiftUI

extension FullRecordsView {
    struct SetView: View {
        let set: ExerciseSet
        
        var body: some View {
            VStack {
                HStack {
                    Text("\(FullRecordsView.formatted(double: set.weight))\(set.unit.rawValue) x \(set.reps)").italic()
                    Spacer()
                }
                .padding(.bottom, 4)
                
                Divider()
            }
        }
    }
}

#Preview {
    FullRecordsView.SetView(set: .init(unit: .kg, reps: 12, weight: 50, id: "123"))
}
