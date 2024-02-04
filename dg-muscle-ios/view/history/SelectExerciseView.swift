//
//  SelectExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/9/23.
//

import SwiftUI

protocol SelectExerciseDependency {
    func select(exercise: Exercise)
}

struct SelectExerciseView: View {
    
    let dependency: SelectExerciseDependency
    
    @StateObject var exerciseStore = store.exercise
    
    var body: some View {
        VStack {
            HStack {
                Text("Select Exercise").font(.largeTitle)
                Spacer()
            }.padding(.horizontal)
            
            List {
                
                ForEach(exerciseStore.exerciseSections) { section in
                    Section {
                        ForEach(section.exercises) { exercise in
                            Button {
                                dependency.select(exercise: exercise)
                            } label: {
                                Text(exercise.name).foregroundStyle(Color(uiColor: .label))
                            }

                        }
                    } footer: {
                        Text(section.part.rawValue)
                    }
                }
            }
        }
    }
}
