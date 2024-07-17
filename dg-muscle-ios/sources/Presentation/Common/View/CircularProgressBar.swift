//
//  CircularProgressBar.swift
//  Common
//
//  Created by 신동규 on 7/17/24.
//

import SwiftUI

public struct CircularProgressView: View {
    let progress: Double
    let lineWidth: Double
    let color: Color
    
    public init(
        progress: Double,
        lineWidth: Double,
        color: Color
    ) {
        self.progress = progress
        self.lineWidth = lineWidth
        self.color = color
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.7, lineWidth: 6, color: .mint)
        .frame(width: 20)
        .preferredColorScheme(.dark)
}
