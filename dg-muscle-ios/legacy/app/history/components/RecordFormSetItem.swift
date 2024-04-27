//
//  RecordFormSetItem.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct RecordFormSetItem: View {
    
    @Binding var set: ExerciseSet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Weight is")
                    .fontWeight(.black).italic()
                Text("\(Int(set.weight))").fontWeight(.heavy)
                Text(set.unit.rawValue).fontWeight(.heavy)
                Spacer()
                
                HStack {
                    
                    Button {
                        set.weight += 1
                    } label: {
                        Image(systemName: "arrowshape.up")
                            .padding(8)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        set.weight -= 1
                    } label: {
                        Image(systemName: "arrowshape.down")
                            .padding(8)
                    }
                    .buttonStyle(.borderless)
                }
                .foregroundStyle(Color(uiColor: .label))
                
            }
            
            HStack {
                Text("\(set.reps)")
                    .fontWeight(.black).italic()
                Text("reps").fontWeight(.heavy)
                
                Spacer()
                
                HStack {
                    Button {
                        set.reps += 1
                    } label: {
                        Image(systemName: "arrowshape.up")
                            .padding(8)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        set.reps -= 1
                    } label: {
                        Image(systemName: "arrowshape.down")
                            .padding(8)
                    }
                    .buttonStyle(.borderless)
                }
                .foregroundStyle(Color(uiColor: .label))
            }
        }
    }
}

#Preview {
    
    @State var set: ExerciseSet = .init(unit: .kg, reps: 10, weight: 75, id: "1")
    
    return RecordFormSetItem(set: $set).preferredColorScheme(.dark)
}
