//
//  PostHistoryViewModel.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Combine
import Domain

class PostHistoryViewModel: ObservableObject {
    @Published var history: HistoryForm
    private let postHistoryUsecase: PostHistoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyRepository: HistoryRepository,
        history: Domain.History?
    ) {
        postHistoryUsecase = .init(historyRepository: historyRepository)
        if let history {
            self.history = .init(domain: history)
        } else {
            self.history = .init()
        }
        
        bind()
    }
    
    private func bind() {
        $history
            .sink { [weak self] history in
                let domain: Domain.History = history.domain
                self?.postHistoryUsecase.implement(history: domain)
            }
            .store(in: &cancellables)
    }
}
