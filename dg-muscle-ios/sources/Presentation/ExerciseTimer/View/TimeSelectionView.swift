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
        VStack {
            HStack {
                ForEach(times[0...2], id: \.self) { time in
                    Button {
                        selection?(time.seconds)
                    } label: {
                        TimerItemView(time: time)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack {
                ForEach(times[3...], id: \.self) { time in
                    Button {
                        selection?(time.seconds)
                    } label: {
                        TimerItemView(time: time)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    TimeSelectionView(selection: nil)
    .preferredColorScheme(.dark)
}
