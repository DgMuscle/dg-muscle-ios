//
//  TimeSelectionView.swift
//  ExerciseTimer
//
//  Created by 신동규 on 8/11/24.
//

import SwiftUI

public struct TimeSelectionView: View {
    
    let selection: ((Int) -> ())?
    let times: [TimeEnum] = TimeEnum.allCases
    
    public init(selection: ((Int) -> ())?) {
        self.selection = selection
    }
    
    public var body: some View {
        HStack {
            ForEach(times, id: \.self) { time in
                Button {
                    selection?(time.seconds)
                } label: {
                    TimerItemView(time: time)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
        }
    }
}

#Preview {
    TimeSelectionView(selection: nil)
    .preferredColorScheme(.dark)
}
