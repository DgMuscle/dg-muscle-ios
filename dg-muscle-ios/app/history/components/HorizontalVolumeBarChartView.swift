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
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                ForEach(datas, id: \.self) { data in
                    Text(data.part.rawValue)
                        .fontWeight(.heavy)
                        .frame(height: 30)
                }
            }
            
            Spacer(minLength: 20)
            
            VStack {
                VStack {
                    ForEach(datas, id: \.self) { data in
                        HorizontalVolumeBarGraph(data: data, maxExerciseVolume: maxExerciseVolume)
                    }
                }
                .padding(.bottom)
                .background(
                    line
                )
                
                volumeText
            }
        }
    }
    
    var line: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle().frame(height: 1)
            }
            HStack {
                Spacer()
                Rectangle().frame(width: 1)
                
                Spacer()
                Rectangle().frame(width: 1)
                
                Spacer()
                Rectangle().frame(width: 1)
                
                Spacer()
                Rectangle().frame(width: 1)
                
                Spacer()
            }
        }
    }
    
    var volumeText: some View {
        HStack {
            Spacer()
            Text("\(Int(maxExerciseVolume) * 1 / 5)")
            Spacer()
            Text("\(Int(maxExerciseVolume) * 2 / 5)")
            Spacer()
            Text("\(Int(maxExerciseVolume) * 3 / 5)")
            Spacer()
            Text("\(Int(maxExerciseVolume) * 4 / 5)")
            Spacer()
            Text("\(Int(maxExerciseVolume))")
        }
        .font(.caption2)
        .fontWeight(.heavy)
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
