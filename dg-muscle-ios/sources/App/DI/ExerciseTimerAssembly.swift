//
//  ExerciseTimerAssembly.swift
//  App
//
//  Created by 신동규 on 8/11/24.
//

import Swinject
import Domain
import ExerciseTimer
import Foundation

public struct ExerciseTimerAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(FloatingTimerView.self) { (_, exerciseTimer: ExerciseTimerDomain) in
            return FloatingTimerView(timer: .init(domain: exerciseTimer))
        }
        
        container.register(TimeSelectionView.self) { (_, timeSelection: ((Int) -> ())?) in
            return TimeSelectionView(selection: timeSelection)
        }
    }
}
