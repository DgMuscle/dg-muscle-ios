//
//  FriendHistoryListItemViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation
import Combine

final class FriendHistoryListItemViewModel: ObservableObject {
    let history: HistoryV
    let friend: UserV
    let exercises: [ExerciseV]
    let color: HeatmapColorV
    private let getDayUsecase: GetDayUsecase
    private let getPartsFromFriendsHistoryUsecase: GetPartsFromFriendsHistoryUsecase
    @Published var day: String = ""
    @Published var parts: [ExerciseV.Part] = []
    @Published var volume: Int = 0
    
    init(history: HistoryV,
         friend: UserV,
         exercises: [ExerciseV],
         color: HeatmapColorV,
         getDayUsecase: GetDayUsecase,
         getPartsFromFriendsHistoryUsecase: GetPartsFromFriendsHistoryUsecase) {
        self.history = history
        self.friend = friend
        self.exercises = exercises
        self.color = color
        self.getDayUsecase = getDayUsecase
        self.getPartsFromFriendsHistoryUsecase = getPartsFromFriendsHistoryUsecase
        
        bind()
    }
    
    private func bind() {
        day = getDayUsecase.implement(history: history.domain)
        parts = getPartsFromFriendsHistoryUsecase.implement(history: history.domain, exercises: exercises.map({ $0.domain })).map({ .init(part: $0) })
        volume = Int(history.volume)
    }
}
