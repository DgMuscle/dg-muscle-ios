//
//  CoordinatorV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI
import Combine

var coordinatorv2InstanceCount: Int = 0

final class CoordinatorV2: ObservableObject {
    @Binding var path: NavigationPath
    
    lazy var exercise = ExerciseCoordinatorV2(path: $path)
    lazy var history = HistoryCoordinatorV2(path: $path)
    lazy var main = MainCoordinatorV2(path: $path)
    
    private var cancellables = Set<AnyCancellable>()
    init(path: Binding<NavigationPath>) {
        coordinatorv2InstanceCount += 1
        self._path = path
        bind()
    }
    
    private func bind() {
        
    }
}
