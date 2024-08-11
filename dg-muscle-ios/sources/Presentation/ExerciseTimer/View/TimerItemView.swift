//
//  TimerItemView.swift
//  ExerciseTimer
//
//  Created by 신동규 on 8/11/24.
//

import SwiftUI

struct TimerItemView: View {
    
    let time: TimeEnum
    
    var body: some View {
        Text(time.rawValue)
            .padding()
            .background {
                Circle()
                    .fill(.clear)
                    .strokeBorder(style: StrokeStyle(
                        lineWidth: 3,
                        dash: [6]
                    ))
                    .foregroundStyle(.orange)
            }
    }
}

#Preview {
    TimerItemView(time: .oneThirty)
        .preferredColorScheme(.dark)
}
