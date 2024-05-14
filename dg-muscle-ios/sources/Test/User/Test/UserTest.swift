//
//  UserTest.swift
//  Test
//
//  Created by Donggyu Shin on 5/14/24.
//

import XCTest
import Domain
import Combine

final class UserTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    func testSubscribeUser() async throws {
        var userId: String?
        let subscribeUserUsecase: SubscribeUserUsecase = .init(userRepository: UserRepositoryTest())
        subscribeUserUsecase.implement().sink { user in
            userId = user?.uid
        }
        .store(in: &cancellables)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertEqual(userId, "taEJh30OpGVsR3FEFN2s67A8FvF3")
    }
}
