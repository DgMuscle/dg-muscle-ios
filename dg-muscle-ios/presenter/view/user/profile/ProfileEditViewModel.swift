//
//  ProfileEditViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

class ProfileEditViewModel: ObservableObject {
    @Published var user: UserV?
    
    private let postUserDisplayNameUsecase: PostUserDisplayNameUsecase
    private let subscribeUserUsecase: SubscribeUserUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(postUserDisplayNameUsecase: PostUserDisplayNameUsecase,
         subscribeUserUsecase: SubscribeUserUsecase) {
        self.postUserDisplayNameUsecase = postUserDisplayNameUsecase
        self.subscribeUserUsecase = subscribeUserUsecase
        bind()
    }
    
    func updateName(name: String?) {
        postUserDisplayNameUsecase.implement(name: name)
    }
    
    private func bind() {
        subscribeUserUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let user else {
                    self?.user = nil
                    return
                }
                self?.user = .init(from: user)
            }
            .store(in: &cancellables)
    }
    
}
