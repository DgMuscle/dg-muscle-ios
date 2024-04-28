//
//  ExerciseItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseItemView: View {
    
    var exercise: ExerciseV
    
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
    
    let exercise: ExerciseV = .init(id: "1", name: "squat", parts: [.leg], favorite: true)
    let exercise2: ExerciseV = .init(id: "2", name: "bench press", parts: [.chest, .arm], favorite: false)
    
    return VStack(spacing: 20) {
        ExerciseItemView(exercise: exercise)
        ExerciseItemView(exercise: exercise2)
    }.preferredColorScheme(.dark)
}
