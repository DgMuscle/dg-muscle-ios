//
//  HorizontalVolumeBarChartView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import SwiftUI

struct HorizontalVolumeBarChartView: View {
    
    var datas: [MonthlySectionViewModel.Data]
    var maxExerciseVolume: Double
    
    var body: some View {
        HStack {
            VStack {
                ForEach(datas, id: \.self) { data in
                    Text(data.part.rawValue)
                        .fontWeight(.heavy)
                        .frame(height: 30)
                }
            }
            
            VStack {
                ForEach(datas, id: \.self) { data in
                    HorizontalVolumeBarGraph(data: data, maxExerciseVolume: maxExerciseVolume)
                }
            }
        }
    }
}

#Preview {
    
    let data1: MonthlySectionViewModel.Data = .init(part: .leg, volume: 11900)
    let data2: MonthlySectionViewModel.Data = .init(part: .chest, volume: 6000)
    let data3: MonthlySectionViewModel.Data = .init(part: .back, volume: 7000)
    
    let datas = [data1, data2, data3]
    
    return HorizontalVolumeBarChartView(datas: datas, maxExerciseVolume: 11900)
        .preferredColorScheme(.dark)
}
