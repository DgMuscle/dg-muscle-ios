//
//  UserRepositoryV2Test.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation

final class UserRepositoryV2Test: UserRepositoryV2 {
    var user: DGUser? {
        _user
    }
    
    var userPublisher: AnyPublisher<DGUser?, Never> {
        $_user.eraseToAnyPublisher()
    }
    
    var isLogin: Bool { _isLogin }
    
    var isLoginPublisher: AnyPublisher<Bool, Never> {
        $_isLogin.eraseToAnyPublisher()
    }
    
    var dgUsers: [DGUser] { _dgUsers }
    
    var dgUsersPublisher: AnyPublisher<[DGUser], Never> {
        $_dgUsers.eraseToAnyPublisher()
    }
    
    @Published private var _user: DGUser?
    @Published private var _isLogin: Bool = true
    @Published private var _dgUsers: [DGUser] = []
    
    init() {
        prepareMockData()
    }
    
    func signOut() throws {
        
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        
    }
    
    func withDrawal() async -> Error? {
        nil
    }
    
    func updateUser(displayName: String?) async throws {
        
    }
    
    func updateUser(photoURL: URL?) async throws {
        
    }
    
    
    private func prepareMockData() {
        /// photo url https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F3D91567D-E280-4861-B3B2-68E571150165.png?alt=media&token=35985183-c69b-4c6d-8e56-f1aba8daabd4
        _user = .init(uid: "uid", displayName: "DONG GYU", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F3D91567D-E280-4861-B3B2-68E571150165.png?alt=media&token=35985183-c69b-4c6d-8e56-f1aba8daabd4"))
        
        _dgUsers = [
            .init(uid: "2Mwgf4vpKLRyz1ynuWBwvcyEBe92", displayName: "Hui", photoURL: nil),
            .init(uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2", displayName: "낙용", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8")),
            .init(uid: "5cLTF5EVsMdtOgYpl6RQKi9xVCE3"),
            .init(uid: "TtR7J1C8hgOG3fnMdqPQIoDPdVZ2", displayName: "죽겠어요", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FTtR7J1C8hgOG3fnMdqPQIoDPdVZ2%2F75A1245A-B92F-4839-A09A-30FFE7E9FA7D.png?alt=media&token=0dfd0613-6b38-4b43-8887-9af3b0b1140a")),
            .init(uid: "uid", displayName: "DONG GYU", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F3D91567D-E280-4861-B3B2-68E571150165.png?alt=media&token=35985183-c69b-4c6d-8e56-f1aba8daabd4"))
        ]
    }
}
