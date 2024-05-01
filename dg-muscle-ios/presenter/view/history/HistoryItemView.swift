//
//  HistoryItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HistoryItemView: View {
    
    @StateObject var viewModel: HistoryItemViewModel
    let exerciseRepository: ExerciseRepository
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                coloredText
                
                HStack {
                    if let time = viewModel.time {
                        Text("Duration: \(time)")
                    }
                    
                    if let kcal = viewModel.kcal {
                        Text("(\(Int(kcal)) kcal)")
                    }
                }
                .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                .font(.caption2)
                .padding(.top, 1)
            }
            .foregroundStyle(Color(uiColor: .label))
            Spacer()
        }
    }
    
    var coloredText: some View {
        let partsText: [Text] = viewModel.parts.map { part in
            Text(part.rawValue.capitalized).fontWeight(.bold).foregroundStyle(viewModel.heatmapColor.color)
        }
        
        if partsText.isEmpty {
            return VStack {
                Text("On the \(viewModel.day)th, I worked out") +
                Text(" as much as ") +
                Text("\(viewModel.volume)").fontWeight(.bold) +
                Text(" volume")
            }
            .multilineTextAlignment(.leading)
        } else {
            var combinedPartsText = partsText.reduce(partsText[0], { $0 + Text(" and ") + $1 })
            if partsText.count == 1 {
                combinedPartsText = partsText[0]
            }
            return VStack {
                Text("On the \(viewModel.day)th, I worked out my ") +
                combinedPartsText +
                Text(" as much as ") +
                Text("\(viewModel.volume)").fontWeight(.bold) +
                Text(" volume")
            }
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let metaData: HistoryMetaDataDomain = .init(duration: 23872, kcalPerHourKg: 83, startDate: Date(), endDate: nil)
    let history = historyRepository.histories.randomElement()!
    var historyV: HistoryV = .init(from: history)
    historyV.metaData = .init(from: metaData)
    let viewModel = HistoryItemViewModel(history: historyV,
                                         getDayUsecase: .init(),
                                         getPartsUsecase: .init(exerciseRepository: exerciseRepository),
                                         getKcalUsecase: .init(healthRepository: healthRepository),
                                         getNaturalDurationUsecase: .init(),
                                         getHeatmapColorUsecase: .init(historyRepository: historyRepository),
                                         subscribeHeatmapColorUsecase: .init(historyRepository: historyRepository)
    )
    return HistoryItemView(viewModel: viewModel,
                           exerciseRepository: exerciseRepository)
    .preferredColorScheme(.dark)
}
