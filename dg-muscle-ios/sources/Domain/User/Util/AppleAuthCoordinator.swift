//
//  AppleAuthCoordinator.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import Foundation

public protocol AppleAuthCoordinatorDelegate: AnyObject {
    func error(message: String)
}

public protocol AppleAuthCoordinator {
    var delegate: AppleAuthCoordinatorDelegate? { get set }
    func startAppleLogin()
}
