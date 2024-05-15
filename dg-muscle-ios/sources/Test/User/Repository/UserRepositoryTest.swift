//
//  UserRepositoryTest.swift
//  Test
//
//  Created by Donggyu Shin on 5/14/24.
//

import Combine
import Domain
import Foundation

final class UserRepositoryTest: UserRepository {
    public var user: AnyPublisher<User?, Never> { $_user.eraseToAnyPublisher() }
    @Published private var _user: User?
    
    init() {
        _user = .init(
            uid: "taEJh30OpGVsR3FEFN2s67A8FvF3",
            displayName: "DG",
            photoURL: .init(
                string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F9F14BFF8-33CE-40BF-822F-BB834CE379FE.png?alt=media&token=bca448b7-f0e6-48fe-9a78-c309220fe7bb"
            )
        )
    }
}
