//
//  PostLogUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public final class PostLogUsecase {
    private let logRepository: LogRepository
    private let userRepository: UserRepository
    
    public init(
        logRepository: LogRepository,
        userRepository: UserRepository
    ) {
        self.logRepository = logRepository
        self.userRepository = userRepository
    }
    
    public func implement(message: String, category: DGLog.Category) {
        let log: DGLog = .init(
            id: UUID().uuidString,
            category: category,
            message: message,
            resolved: false,
            createdAt: .init(),
            creator: userRepository.get()?.uid
        )
        
        logRepository.post(log: log)
    }
}
