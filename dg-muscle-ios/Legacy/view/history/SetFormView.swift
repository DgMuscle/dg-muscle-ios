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
    
    private let buttonHeight: CGFloat = 20
    
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
                    
                    Button {
                        weight = weight + 5
                    } label: {
                        Image(systemName: "plus").font(.caption2).foregroundStyle(.tint)
                            .frame(height: buttonHeight)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        if weight >= 5 {
                            weight = weight - 5
                        }
                    } label: {
                        Image(systemName: "minus").font(.caption2).foregroundStyle(.tint)
                            .frame(height: buttonHeight)
                    }
                    .buttonStyle(.bordered)
                }
                
                HStack {
                    TextField("reps", value: $reps, format: .number)
                        .keyboardType(.numberPad)
                    Text("reps").foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                    
                    Button {
                        reps = reps + 1
                    } label: {
                        Image(systemName: "plus").font(.caption2).foregroundStyle(.tint)
                            .frame(height: buttonHeight)
                    }
                    .buttonStyle(.bordered)

                    Button {
                        if reps >= 1 {
                            reps = reps - 1
                        }
                    } label: {
                        Image(systemName: "minus").font(.caption2).foregroundStyle(.tint)
                            .frame(height: buttonHeight)
                    }
                    .buttonStyle(.bordered)
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
