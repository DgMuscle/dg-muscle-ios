//
//  HeatMapColumnView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/15/24.
//

import SwiftUI

struct HeatMapColumnView: View {
    
    @State var data: WorkoutHeatMapViewModel.Data
    @State var maxVolume: Double
    
    private let size: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 4) {
            ForEach(data.volumes, id: \.self) { volume in
                
                if volume == 0 {
                    RoundedRectangle(cornerRadius: 2).fill(.gray).opacity(0.2)
                        .frame(width: size, height: size)
                } else {
                    RoundedRectangle(cornerRadius: 2).fill(.green).opacity(volume / maxVolume)
                        .frame(width: size, height: size)
                }
            }
        }
    }
}

#Preview {
    
    let data: WorkoutHeatMapViewModel.Data = .init(week: "202416", volumes: [4, 0, 4, 8, 10])
    
    return HeatMapColumnView(data: data, maxVolume: 10)
        .preferredColorScheme(.dark)
}
