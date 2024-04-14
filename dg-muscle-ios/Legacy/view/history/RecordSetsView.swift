//
//  RecordSetsView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/8/23.
//

import SwiftUI

struct RecordSetsView: View {
    
    let record: Record
    let dateString: String
    
    var exercise: Exercise? {
        store.exercise.exercises.first(where: { $0.id == record.exerciseId })
    }
    
    var body: some View {
        
        if let exercise {
            VStack {
                HStack {
                    Text("Record sets").font(.largeTitle)
                    Text("(\(exercise.name))")
                    Spacer()
                }.padding(.horizontal)
                
                HStack {
                    Text(dateString).foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                    Spacer()
                }.padding(.horizontal)
                
                List {
                    ForEach(record.sets) { set in
                        HStack(spacing: 0) {
                            Text("\(Int(set.weight))")
                            Text(set.unit.rawValue)
                            Text(" x ")
                            Text("\(set.reps)")
                            Spacer()
                            Text("\(Int(set.volume))").italic().foregroundStyle(Color.green)
                        }
                    }
                    HStack {
                        Text("total volumes")
                        Spacer()
                        Text("\(Int(record.volume))").italic().foregroundStyle(.tint)
                    }
                }
                .scrollIndicators(.hidden)
            }
        } else {
            VStack(alignment: .leading) {
                Text("Unavailable to show this record").font(.largeTitle)
                Text("Exercise of this record was deleted").foregroundStyle(Color.red)
            }
            .padding()
        }
    }
}
