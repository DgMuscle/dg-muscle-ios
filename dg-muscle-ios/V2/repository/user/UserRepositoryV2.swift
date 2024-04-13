//
//  UserRepositoryV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//
import Combine

protocol UserRepositoryV2 {
    var user: DGUser? { get }
    var userPublisher: AnyPublisher<DGUser?, Never> { get }
    var isLogin: Bool { get }
}
