//
//  FloatingTimerView.swift
//  ExerciseTimer
//
//  Created by 신동규 on 8/11/24.
//

import SwiftUI

public struct FloatingTimerView: View {
    
    let timer: ExerciseTimerPresentation
    
    public init(timer: ExerciseTimerPresentation) {
        self.timer = timer
    }
    
    public var body: some View {
        HStack {
            Text(timer.remainTime)
                .opacity(0.9)
        }
        .frame(width: 200)
        .padding(.vertical, 8)
        .background {
            Capsule()
                .fill(.thinMaterial)
                .overlay {
                    HStack {
                        Spacer()
                        ProgressView()
                            .tint(.orange)
                            .padding(.trailing)
                    }
                }
                .opacity(0.6)
        }
    }
}

#Preview {
    
    var date = Date()
    
    date = Calendar.current.date(byAdding: .second, value: 90, to: date)!
    
    return FloatingTimerView(timer: .init(domain: .init(targetDate: date)))
        .contextMenu {
            Button("Cancel") {
                print("cancel")
            }
        }
        .preferredColorScheme(.dark)
}
