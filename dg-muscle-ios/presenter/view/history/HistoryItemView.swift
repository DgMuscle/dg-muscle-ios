//
//  HistoryItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HistoryItemView: View {
    
    @StateObject var viewModel: HistoryItemViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                    Text(viewModel.day).fontWeight(.heavy)
                }
                .font(.title3)
                .padding(.leading, 2)
                
                HStack {
                    Text("Parts:")
                    Text(viewModel.parts.map({ $0.rawValue }).joined(separator: ", "))
                        .fontWeight(.heavy)
                }
                
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
        }
    }
}

#Preview {
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let metaData: HistoryMetaDataDomain = .init(duration: 23872, kcalPerHourKg: 83, startDate: Date(), endDate: nil)
    let history = historyRepository.histories.randomElement()!
    
    let viewModel = HistoryItemViewModel(history: .init(from: history),
                                         getDayUsecase: .init(history: history),
                                         getPartsUsecase: .init(history: history, exerciseRepository: exerciseRepository),
                                         getKcalUsecase: .init(metadata: metaData, healthRepository: healthRepository),
                                         getNaturalDurationUsecase: .init(metadata: metaData))
    return HistoryItemView(viewModel: viewModel).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
