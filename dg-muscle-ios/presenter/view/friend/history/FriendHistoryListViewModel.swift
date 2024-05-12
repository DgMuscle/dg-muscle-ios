//
//  FriendHistoryListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation
import Combine

final class FriendHistoryListViewModel: ObservableObject {
    
    @Published var sections: [HistorySectionV] = []
    @Published var heatmap: [HeatmapV] = []
    @Published var heatmapColor: HeatmapColorV
    @Published var exercises: [ExerciseV] = []
    @Published var loading: Bool = true
    
    let friend: UserV
    private let getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase
    private let getHistoriesFromUidUsecase: GetHistoriesFromUidUsecase
    private let generateHeatmapFromHistoryUsecase: GenerateHeatmapFromHistoryUsecase
    private let getFriendExercisesUsecase: GetFriendExercisesUsecase
    private var cancellables = Set<AnyCancellable>()
    init(friend: UserV,
         getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase,
         getHistoriesFromUidUsecase: GetHistoriesFromUidUsecase,
         generateHeatmapFromHistoryUsecase: GenerateHeatmapFromHistoryUsecase,
         getFriendExercisesUsecase: GetFriendExercisesUsecase) {
        self.friend = friend
        self.heatmapColor = friend.heatmapColor
        self.getFriendGroupedHistoriesUsecase = getFriendGroupedHistoriesUsecase
        self.getHistoriesFromUidUsecase = getHistoriesFromUidUsecase
        self.generateHeatmapFromHistoryUsecase = generateHeatmapFromHistoryUsecase
        self.getFriendExercisesUsecase = getFriendExercisesUsecase
        
        configureSections()
        configureHeatmap()
        bind()
    }
    
    private func bind() {
        $heatmap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] heatmap in
                self?.loading = heatmap.isEmpty
            }
            .store(in: &cancellables)
    }
    
    private func configureSections() {
        Task {
            let exercises = try await getFriendExercisesUsecase.implement(friendId: friend.uid)
            let historiesDomain: [[HistoryDomain]] = try await getFriendGroupedHistoriesUsecase.implement(friendId: friend.uid)
            let historiesV: [[HistoryV]] = historiesDomain.map({ $0.map({ HistoryV(from: $0) }) })
            let sections: [HistorySectionV] = historiesV.map({ .init(histories: $0) })
            DispatchQueue.main.async { [weak self] in
                self?.exercises = exercises.map({ .init(from: $0) })
                self?.sections = sections
            }
        }
    }
    
    private func configureHeatmap() {
        Task {
            let histories = try await getHistoriesFromUidUsecase.implement(uid: friend.uid)
            let heatmapDomain = generateHeatmapFromHistoryUsecase.implement(histories: histories)
            let heatmap: [HeatmapV] = heatmapDomain.map({ .init(from: $0) })
            DispatchQueue.main.async { [weak self] in
                self?.heatmap = heatmap
            }
        }
    }
}
