//
//  HistorySectionViewV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HistorySectionViewV2: View {
    
    var section: HistorySectionV
    
    let tapHistory: ((HistoryV) -> ())?
    let deleteHistory: ((HistoryV) -> ())?
    let tapHeader: (() -> ())?
    
    let exerciseRepository: ExerciseRepository
    let healthRepository: HealthRepositoryDomain
    
    var body: some View {
        VStack {
            Button {
                tapHeader?()
            } label: {
                HStack {
                    Text(section.header)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Spacer()
                }
                .foregroundStyle(LinearGradient(colors: [Color(uiColor: .label),
                                                         Color(uiColor: .label).opacity(0.4)],
                                                startPoint: .leading,
                                                endPoint: .trailing))
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            
            ForEach(section.histories) { history in
                Button {
                    tapHistory?(history)
                } label: {
                    HistoryItemView(viewModel: .init(history: history,
                                                     getDayUsecase: .init(history: history.domain),
                                                     getPartsUsecase: .init(history: history.domain, exerciseRepository: exerciseRepository),
                                                     getKcalUsecase: getKcalUsecase(history: history),
                                                     getNaturalDurationUsecase: getNaturalDurationUsecase(history: history)))
                }
            }
        }
    }
    
    func getKcalUsecase(history: HistoryV) -> GetKcalUsecase? {
        guard let metaData = history.metaData else { return nil }
        return .init(metadata: metaData.domain, healthRepository: healthRepository)
    }
    
    func getNaturalDurationUsecase(history: HistoryV) -> GetNaturalDurationUsecase? {
        guard let metaData = history.metaData else { return nil }
        return .init(metadata: metaData.domain)
    }
}
