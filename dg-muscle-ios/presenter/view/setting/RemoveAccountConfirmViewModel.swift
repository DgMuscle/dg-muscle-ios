//
//  RemoveAccountConfirmViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation
import Combine

final class RemoveAccountConfirmViewModel: ObservableObject {
    @Published var displayName: String = ""
    @Published var errorMessage: String?
    
    private let getUserUsecase: GetUserUsecase
    private var cancellables = Set<AnyCancellable>()
    init(getUserUsecase: GetUserUsecase) {
        self.getUserUsecase = getUserUsecase
    }
    
    func tapRemoveAccount(completion: (() -> ())?) {
        errorMessage = nil
        guard let domainUser = getUserUsecase.implement() else { return }
        if domainUser.uid == "taEJh30OpGVsR3FEFN2s67A8FvF3" {
            errorMessage = "Admin account can't be deleted"
            return
        }
        let user: UserV = .init(from: domainUser)
        if user.displayName == nil {
            if displayName == "" {
                completion?()
            } else {
                errorMessage = "If you don't have display name yet, just enter empty text"
            }
            return
        }
        
        if user.displayName == displayName {
            completion?()
        } else {
            errorMessage = "Please enter exact display name"
        }
    }
}
