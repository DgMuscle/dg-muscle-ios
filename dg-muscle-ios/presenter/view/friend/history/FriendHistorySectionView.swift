//
//  FriendHistorySectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import SwiftUI

struct FriendHistorySectionView: View {
    let section: HistorySectionV
    let friend: UserV
    let exercises: [ExerciseV]
    let color: HeatmapColorV
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(section.header)
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
            
            ForEach(section.histories) { history in
                Button {
                    print("tap history")
                } label: {
                    FriendHistoryListItemView(viewModel: .init(history: history,
                                                               friend: friend,
                                                               exercises: exercises,
                                                               color: color,
                                                               getDayUsecase: .init(),
                                                               getPartsFromFriendsHistoryUsecase: .init())
                    )
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}
