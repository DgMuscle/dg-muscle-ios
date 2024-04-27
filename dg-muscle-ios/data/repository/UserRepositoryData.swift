//
//  UserRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

final class UserRepositoryData {
    static let shared = UserRepositoryData()
    
    var isLoginPublisher: AnyPublisher<Bool, Never> { $_isLogin.eraseToAnyPublisher() }
    
    @Published private var _isLogin: Bool = true
    
    private init() { }
}
