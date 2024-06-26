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
        Section("give it a try") {
            HStack {
                Text(String(goal.weight)).foregroundStyle(color) +
                Text(" kg x ") +
                Text("\(goal.reps)").foregroundStyle(color)
                
                Spacer()
                
                Image(systemName: "flag.checkered")
                    .foregroundStyle(goal.achive ? color : .gray)
            }
        }
    }
}

#Preview {
    List {
        GoalView(goal: .init(weight: 70, reps: 9, achive: false), color: .purple)
    }
    .preferredColorScheme(.dark)
}
