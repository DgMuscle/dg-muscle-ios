//
//  ManageSetView.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import Foundation
import SwiftUI
import MockData
import Common

struct ManageSetView: View {
    
    @State var set: ExerciseSet
    let color: Color
    let saveAction: ((ExerciseSet) -> ())?
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                HStack {
                    Text("WEIGHT").font(.caption)
                    Spacer()
                }
                HStack {
                    TextField("WEIGHT", value: $set.weight, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    Text(set.unit.rawValue)
                    Spacer(minLength: 15)
                    
                    Button {
                        set.weight += 5
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(color)
                    }
                    
                    Button {
                        set.weight -= 5
                    } label: {
                        Image(systemName: "minus")
                            .foregroundStyle(color)
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("REPS").font(.caption)
                    Spacer()
                }
                HStack {
                    TextField("WEIGHT", value: $set.reps, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Text(set.unit.rawValue).hidden()
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        set.reps += 1
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(color)
                    }
                    
                    Button {
                        set.reps -= 1
                    } label: {
                        Image(systemName: "minus")
                            .foregroundStyle(color)
                    }
                }
            }
            
            Common.GradientButton(action: {
                saveAction?(set)
            }, text: "SAVE", backgroundColor: color)
        }
    }
}

#Preview {
    return ManageSetView(
        set: .init(domain: SETS_1.first!),
        color: .mint, 
        saveAction: nil
    )
        .preferredColorScheme(.dark)
}
