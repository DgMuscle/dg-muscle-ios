//
//  FriendRequestListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation
import Combine

final class FriendRequestListViewModel: ObservableObject {
    
    @Published var requests: [FriendRequestV] = []
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var successMessage: String? = nil
    
    private let subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase
    private let acceptFriendUsecase: AcceptFriendUsecase
    private let refuseFriendUsecase: RefuseFriendUsecase
    private let getUserFromUserIdUsecase: GetUserFromUserIdUsecase
    private let appendFriendUsecase: AppendFriendUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase,
         acceptFriendUsecase: AcceptFriendUsecase,
         refuseFriendUsecase: RefuseFriendUsecase,
         getUserFromUserIdUsecase: GetUserFromUserIdUsecase,
         appendFriendUsecase: AppendFriendUsecase) {
        self.subscribeFriendRequestsUsecase = subscribeFriendRequestsUsecase
        self.acceptFriendUsecase = acceptFriendUsecase
        self.refuseFriendUsecase = refuseFriendUsecase
        self.getUserFromUserIdUsecase = getUserFromUserIdUsecase
        self.appendFriendUsecase = appendFriendUsecase
        bind()
    }
    
    @MainActor
    func accept(request: FriendRequestV) {
        loadingHandler { [weak self] in
            try await self?.acceptFriendUsecase.implement(request: request.domain)
            self?.appendFriendUsecase.implement(friendId: request.fromId)
        }
    }
    
    @MainActor
    func refuse(request: FriendRequestV) {
        loadingHandler { [weak self] in
            try await self?.refuseFriendUsecase.implement(request: request.domain)
        }
    }
    
    private func loadingHandler(operation: @escaping () async throws -> ()) {
        Task {
            successMessage = nil
            errorMessage = nil
            guard loading == false else { return }
            loading = true
            do {
                try await operation()
                successMessage = "Done"
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
    }
    
    private func bind() {
        subscribeFriendRequestsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] requests in
                guard let self else { return }
                self.requests = requests.sorted(by: { $0.createdAt > $1.createdAt }).map({ .init(from: $0) })
                fetchUsers()
            }
            .store(in: &cancellables)
    }
    
    private func fetchUsers() {
        for (index, request) in requests.enumerated() {
            Task {
                guard request.sender == nil else { return }
                let user = try await getUserFromUserIdUsecase.implement(uid: request.fromId)
                DispatchQueue.main.async { [weak self] in
                    self?.requests[index].sender = .init(from: user)
                }
            }
        }
    }
}
