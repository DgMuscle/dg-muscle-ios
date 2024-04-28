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
                                                     getDayUsecase: .init(),
                                                     getPartsUsecase: .init(exerciseRepository: exerciseRepository),
                                                     getKcalUsecase: .init(healthRepository: healthRepository),
                                                     getNaturalDurationUsecase: .init())
                    )
                }
            }
        }
    }
}
