//
//  RemoteCoordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

final class RemoteCoordinator {
    static let shared = RemoteCoordinator()
    
    @Published var quickAction: QuickAction? = nil
    
    private init() { }
    
    func quickAction(quickAction: QuickAction) {
        self.quickAction = quickAction
    }
}
