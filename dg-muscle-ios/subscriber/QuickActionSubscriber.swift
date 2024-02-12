//
//  QuickActionSubscriber.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import Combine

final class QuickActionSubscriber: AddHistorySubscribable {
    static let shared = QuickActionSubscriber()
    
    @Published var addHistory = false
    @Published var exerciseList = false
    
    lazy var addHistoryPublisher: AnyPublisher<Bool, Never> = $addHistory.eraseToAnyPublisher()
    lazy var exerciseListPublisher: AnyPublisher<Bool, Never> = $exerciseList.eraseToAnyPublisher()
    
    private init() { }
}
