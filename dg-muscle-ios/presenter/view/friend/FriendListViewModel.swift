//
//  FriendListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class FriendListViewModel: ObservableObject {
    @Published var friends: [UserV] = [] 
    
    private let getMyFriendsUsecase: GetMyFriendsUsecase
    private var cancellables = Set<AnyCancellable>()
    init(getMyFriendsUsecase: GetMyFriendsUsecase) {
        self.getMyFriendsUsecase = getMyFriendsUsecase
        
        friends = getMyFriendsUsecase.implement().map({ .init(from: $0) })
    }
}
