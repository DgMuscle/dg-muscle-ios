//
//  ExerciseInfoContainerView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/19/23.
//

import SwiftUI

protocol ExerciseInfoContainerDependency {
    func addExercise(exercise: Exercise)
}

struct ExerciseInfoContainerView: View {
    let contentView: AnyView
    let exerciseName: String
    let exerciseParts: [Exercise.Part]
    let dependency: ExerciseInfoContainerDependency
    
    @State var isShowingMenuItems = false
    @State var isShowingAddExerciseBottomSheet = false
    @State var exerciseFavorite = true
    @StateObject var exerciseStore: ExerciseStore
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            contentView
            
            VStack(alignment: .trailing) {
                Spacer()
                
                if isShowingMenuItems {
                    VStack {
                        Button {
                            withAnimation {
                                isShowing.toggle()
                            }
                        } label: {
                            Image(systemName: "pip.exit")
                                .foregroundStyle(.white)
                                .bold()
                                .padding(10)
                        }
                        
                        Button {
                            isShowingAddExerciseBottomSheet.toggle()
                        } label: {
                            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                .foregroundStyle(.white)
                                .bold()
                                .padding(10)
                        }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray).opacity(0.7)
                    }
                    .transition(.scale)
                }
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            isShowingMenuItems.toggle()
                        }
                    } label: {
                        Image(systemName: "menucard")
                            .foregroundStyle(.white)
                            .bold()
                            .padding(10)
                            .background { Circle().fill(.red).opacity(0.7) }
                    }
                }
            }
            .padding(.trailing, 20)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isShowingAddExerciseBottomSheet, content: {
            VStack(alignment: .leading) {
                
                HStack(spacing: 20) {
                    Text("Do you want to add this exercise into you exercise list?")
                    
                    Button {
                        let exercise = Exercise(id: UUID().uuidString, name: exerciseName, parts: exerciseParts, favorite: exerciseFavorite, order: exerciseStore.exercises.count + 1, createdAt: nil)
                        dependency.addExercise(exercise: exercise)
                        withAnimation {
                            isShowing.toggle()
                        }
                    } label: {
                        Text("yes").foregroundStyle(.white)
                            .padding(8)
                            .background { RoundedRectangle(cornerRadius: 4).fill(.red).opacity(0.6) }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("name: \(exerciseName)")
                    Text("exercise parts: \(partsToString(parts: exerciseParts))")
                    
                    Toggle("favorite", isOn: $exerciseFavorite)
                }
                .padding()
                .background { RoundedRectangle(cornerRadius: 8).fill(.black) }
                
            }
            .presentationDetents([.height(260), .medium])
            .padding()
        })
    }
    
    private func partsToString(parts: [Exercise.Part]) -> String {
        parts.map({ $0.rawValue }).joined(separator: ", ")
    }
}

#Preview {
    struct DP: ExerciseInfoContainerDependency {
        func addExercise(exercise: Exercise) {
            print(exercise)
        }
    }
    return ExerciseInfoContainerView(contentView: AnyView(SquatInfoView()), exerciseName: "squat", exerciseParts: [.leg], dependency: DP(), exerciseStore: store.exercise, isShowing: .constant(true))
}

