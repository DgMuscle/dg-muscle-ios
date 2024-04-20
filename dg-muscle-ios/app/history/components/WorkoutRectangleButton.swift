//
//  WorkoutRectangleButton.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct WorkoutRectangleButton: View {
    var body: some View {
        HStack {
            Text("WORKOUT")
            Image(systemName: "figure.strengthtraining.traditional")
            Spacer()
        }
        .foregroundStyle(Color(uiColor: .label))
        .fontWeight(.black)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
        )
        .padding(.vertical)
    }
}

#Preview {
    WorkoutRectangleButton()
}
