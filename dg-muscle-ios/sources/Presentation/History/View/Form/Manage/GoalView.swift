//
//  GoalView.swift
//  History
//
//  Created by 신동규 on 6/26/24.
//

import SwiftUI
import Common

struct GoalView: View {
    
    let goal: Goal
    let color: Color
    let trainingMode: TrainingMode
    
    var body: some View {
        Section {
            HStack {
                Text(String(goal.weight)).foregroundStyle(color) +
                Text(" kg x ") +
                Text("\(goal.reps)").foregroundStyle(color)
                
                if trainingMode == .strength {
                    Text("x 5")
                }
                
                Spacer()
                
                Image(systemName: "flag.checkered")
                    .foregroundStyle(goal.achive ? .green : .gray)
            }
        } header: {
            Text("give it a try(\(trainingMode.text))")
        } footer: {
            if goal.achive {
                Text("You did it!").foregroundStyle(.green)
            } else {
                Text("Long press to toggle")
            }
        }
    }
}

#Preview {
    List {
        GoalView(goal: .init(weight: 70, reps: 9, achive: true), color: .purple, trainingMode: .mass)
        
        GoalView(goal: .init(weight: 70, reps: 5, achive: true), color: .purple, trainingMode: .strength)
    }
    .preferredColorScheme(.dark)
}
