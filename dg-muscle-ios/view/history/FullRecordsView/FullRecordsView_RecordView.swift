//
//  FullRecordsView_RecordView.swift
//  dg-muscle-workspace
//
//  Created by 신동규 on 3/1/24.
//

import SwiftUI

extension FullRecordsView {
    struct RecordView: View {
        @State var record: Record
        let exercise: Exercise?
        
        var body: some View {
            VStack {
                if let exercise {
                    HStack {
                        Text(exercise.name).font(.title).italic()
                        Spacer()
                    }.padding(.bottom)

                    ForEach(record.sets) { set in
                        SetView(set: set)
                    }
                    
                    HStack {
                        Text("\(exercise.name) volume is")
                        Text("\(FullRecordsView.formatted(double: record.volume))")
                            .foregroundStyle(.tint)
                            .italic()
                        Spacer()
                    }
                } else {
                    HStack {
                        Text("Data is unreadable due to absence of exercise data")
                            .foregroundStyle(.red)
                            .italic()
                        
                        Spacer()
                    }
                }
            }
        }
    }
}
