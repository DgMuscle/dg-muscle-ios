//
//  SetFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/2/23.
//

import SwiftUI

protocol SetFormViewDependency {
    func save(data: ExerciseSet)
}

struct SetFormView: View {
    
    let dependency: SetFormViewDependency
    
    @State var unit: ExerciseSet.Unit
    @State var reps: Int
    @State var weight: Double
    
    var body: some View {
        VStack {
            HStack {
                Text("Set Form").font(.largeTitle)
                Spacer()
            }
            .padding()
            
            Form {
                HStack {
                    TextField("weight", value: $weight, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Text(unit.rawValue)
                        .foregroundStyle(.tint)
                        .onTapGesture {
                            withAnimation {
                                if unit == .kg {
                                    unit = .lb
                                } else {
                                    unit = .kg
                                }
                            }
                        }
                    Image(systemName: "plus").font(.caption2).foregroundStyle(.tint)
                        .padding(6)
                        .onTapGesture {
                            withAnimation {
                                weight = weight + 5
                            }
                        }
                    Image(systemName: "minus").font(.caption2).foregroundStyle(.tint)
                        .padding(6)
                        .onTapGesture {
                            if weight > 5 {
                                withAnimation {
                                    weight = weight - 5
                                }
                            }
                        }
                }
                
                HStack {
                    TextField("reps", value: $reps, format: .number)
                        .keyboardType(.numberPad)
                    Text("reps").foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                    Image(systemName: "plus").font(.caption2).foregroundStyle(.tint)
                        .padding(6)
                        .onTapGesture {
                            withAnimation {
                                reps = reps + 1
                            }
                        }
                    Image(systemName: "minus").font(.caption2).foregroundStyle(.tint)
                        .padding(6)
                        .onTapGesture {
                            if reps > 1 {
                                withAnimation {
                                    reps = reps - 1
                                }
                            }
                        }
                }
            }
            
            if reps > 0 && weight > 0 {
                Button {
                    let data = ExerciseSet(unit: unit, reps: reps, weight: weight)
                    dependency.save(data: data)
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10).fill(.blue)
                        }
                        .padding()
                }
            }
        }
    }
}
