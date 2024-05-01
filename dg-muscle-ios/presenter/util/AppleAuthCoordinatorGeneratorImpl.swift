//
//  AppleAuthCoordinatorGeneratorImpl.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation
import UIKit

final class AppleAuthCoordinatorGeneratorImpl: AppleAuthCoordinatorGenerator {
    func generate(window: UIWindow?) -> AppleAuthCoordinatorInterface {
        AppleAuthCoordinator(window: window)
    }
}
