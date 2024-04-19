//
//  WorkoutFloatingButton.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct WorkoutFloatingButton: View {
    var body: some View {
        HStack {
            Text("WORKOUT")
            Image(systemName: "figure.strengthtraining.traditional")
        }
        .foregroundStyle(Color(uiColor: .label))
        .fontWeight(.black)
        .padding()
        .background(
            Capsule()
                .fill(
                    LinearGradient(colors: [Color(uiColor: .secondarySystemGroupedBackground), Color(uiColor: .systemBackground)],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .shadow(color: Color(uiColor: .label), radius: 0.1, y: 1)
        )
    }
}

#Preview {
    WorkoutFloatingButton()
}
