//
//  Coordinator.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation
import SwiftUI
import Domain
import History
import Friend
import Common

public var coordinator: Coordinator?

// TODO: Coordinator 나누기

public final class Coordinator {
    @Binding var path: NavigationPath
    
    public let exercise: ExerciseCoordinator
    public let friend: FriendCoordinator
    public let history: HistoryCoordinator
    public let my: MyCoordinator
    
    init(
        path: Binding<NavigationPath>,
        historyRepository: HistoryRepository
    ) {
        self._path = path
        self.exercise = .init(path: path)
        self.friend = .init(path: path)
        self.history = .init(path: path, historyRepository: historyRepository)
        self.my = .init(path: path)
    }
    
    public func pop(_ k: Int = 1) {
        path.removeLast(k)
    }
}
