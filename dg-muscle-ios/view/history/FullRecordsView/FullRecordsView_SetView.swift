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
                    Text("\(set.reps) x \(FullRecordsView.formatted(double: set.weight))").italic()
                    Spacer()
                }
                .padding(.bottom, 4)
                
                Divider()
            }
        }
    }
}
