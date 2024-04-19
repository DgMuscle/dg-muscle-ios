//
//  HorizontalVolumeBarGraph.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import SwiftUI

struct HorizontalVolumeBarGraph: View {
    
    var data: MonthlySectionViewModel.Data
    var maxExerciseVolume: Double
    
    @State private var animate: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(data.part.color.opacity(0.9))
                .frame(width: geometry.size.width * (data.volume / maxExerciseVolume) )
                .onAppear {
                    animate.toggle()
                }
            .animation(.linear(duration: 3).repeatForever(autoreverses: true), value: animate)
        }
        .frame(height: 30)
    }
}

#Preview {
    
    let data: MonthlySectionViewModel.Data = .init(part: .leg, volume: 11900)
    
    return HorizontalVolumeBarGraph(data: data,
                             maxExerciseVolume: 13900)
    .preferredColorScheme(.dark)
}
