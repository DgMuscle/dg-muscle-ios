//
//  FriendHistoryListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import SwiftUI

struct FriendHistoryListItemView: View {
    @StateObject var viewModel: FriendHistoryListItemViewModel
    var body: some View {
        HStack {
            coloredText
            Spacer()
        }
        .foregroundStyle(Color(uiColor: .label))
    }
    
    var coloredText: some View {
        let partsText: [Text] = viewModel.parts.map { part in
            Text(part.rawValue.capitalized).fontWeight(.bold).foregroundStyle(viewModel.color.color)
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
            var combinedPartsText = partsText.reduce(Text(""), { $0 + Text(" and ") + $1 })
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
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let history = historyRepository.histories.randomElement()!
    var historyV: HistoryV = .init(from: history)
    let friend: UserV = .init(from: FriendRepositoryTest().friends.randomElement()!)
    let exercises: [ExerciseV] = ExerciseRepositoryTest().exercises.map({ .init(from: $0) })
    
    return FriendHistoryListItemView(viewModel: .init(history: historyV,
                                                      friend: friend,
                                                      exercises: exercises,
                                                      color: .blue,
                                                      getDayUsecase: .init(),
                                                      getPartsFromFriendsHistoryUsecase: .init()))
    .preferredColorScheme(.dark)
}
