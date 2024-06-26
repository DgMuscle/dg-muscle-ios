//
//  GoalView.swift
//  History
//
//  Created by 신동규 on 6/26/24.
//

import SwiftUI

struct GoalView: View {
    
    let goal: Goal
    let color: Color
    
    var body: some View {
        Section {
            HStack {
                Text(String(goal.weight)).foregroundStyle(color) +
                Text(" kg x ") +
                Text("\(goal.reps)").foregroundStyle(color)
                
                Spacer()
                
                Image(systemName: "flag.checkered")
                    .foregroundStyle(goal.achive ? .green : .gray)
            }
        } header: {
            Text("give it a try")
        } footer: {
            if goal.achive {
                Text("You did it!").foregroundStyle(.green)
            }
        }
    }
}

#Preview {
    List {
        GoalView(goal: .init(weight: 70, reps: 9, achive: true), color: .purple)
    }
    .preferredColorScheme(.dark)
}
