//
//  ExerciseEmptyView.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import Common

struct ExerciseEmptyView: View {
    
    let action: (() -> ())?
    
    var body: some View {
        VStack(spacing: 30) {
            Text(
                """
                No Exercises have discovered.
                Create your first Exercise.
                """
            )
            .multilineTextAlignment(.center)
            
            Common.GradientButton(action: action, text: "ADD")
        }
    }
}

#Preview {
    return ExerciseEmptyView(action: nil)
        .preferredColorScheme(.dark)
}
