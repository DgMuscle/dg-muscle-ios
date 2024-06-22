//
//  LogRepository.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Combine

public protocol LogRepository {
    var logs: AnyPublisher<[DGLog], Never> { get }
    
    func post(log: DGLog)
}
