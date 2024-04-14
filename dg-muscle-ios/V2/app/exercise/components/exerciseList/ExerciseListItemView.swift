//
//  ExerciseListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListItemView: View {
    
    @State var exercise: Exercise
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(exercise.name)")
                        .fontWeight(.black)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    if exercise.favorite {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                    }
                }
                
                
                Text(getParts())
                    .italic()
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
    
    private func getParts() -> String {
        exercise.parts.map({ $0.rawValue }).sorted().joined(separator: ", ")
    }
}

#Preview {
    let exercise: Exercise = .init(id: "1", name: "squat", parts: [.leg], favorite: true, order: 0, createdAt: nil)
    let exercise2: Exercise = .init(id: "2", name: "bench press", parts: [.chest, .arm], favorite: false, order: 0, createdAt: nil)
    
    return VStack(spacing: 20) {
        ExerciseListItemView(exercise: exercise)
        ExerciseListItemView(exercise: exercise2)
    }.preferredColorScheme(.dark)
    
}
