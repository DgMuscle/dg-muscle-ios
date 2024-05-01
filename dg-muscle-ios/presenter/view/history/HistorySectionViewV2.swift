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
    
    let color: HeatmapColorV
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                tapHeader?()
            } label: {
                HStack {
                    Text(section.header)
                        .font(.title2)
                        .fontWeight(.black)
                    Spacer()
                }
                .padding(.bottom)
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
                                                     getNaturalDurationUsecase: .init()
                                                    ),
                                    exerciseRepository: exerciseRepository,
                                    color: color
                    )
                    .padding(.bottom, 20)
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
                    .contextMenu {
                        if let deleteHistory {
                            Button("DELETE HISTORY") {
                                deleteHistory(history)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let histories: [HistoryV] = historyRepository.histories.map({ .init(from: $0) })
    let section: HistorySectionV = .init(histories: histories[0..<5].map({ $0 }))
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    
    return HistorySectionViewV2(section: section,
                                tapHistory: nil,
                                deleteHistory: nil,
                                tapHeader: nil,
                                exerciseRepository: exerciseRepository,
                                healthRepository: healthRepository,
                                color: .mint)
    .preferredColorScheme(.dark)
}
