//
//  FriendRepositoryTest.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class FriendRepositoryTest: FriendRepository {
    var friends: [UserDomain] { _friends }
    var friendsPublisher: AnyPublisher<[UserDomain], Never> { $_friends.eraseToAnyPublisher() }
    @Published private var _friends: [UserDomain] = []
    
    init() {
        prepareMockData()
    }
    
    private func prepareMockData() {
        _friends = [
            .init(uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2", displayName: "낙용", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8")),
            .init(uid: "5cLTF5EVsMdtOgYpl6RQKi9xVCE3"),
            .init(uid: "uid", displayName: "DONG GYU", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F3D91567D-E280-4861-B3B2-68E571150165.png?alt=media&token=35985183-c69b-4c6d-8e56-f1aba8daabd4"))
        ]
    }
    
}
