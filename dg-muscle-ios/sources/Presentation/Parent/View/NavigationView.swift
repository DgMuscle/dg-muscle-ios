//
//  NavigationView.swift
//  Presentation
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import Domain
import Exercise
import History

public struct NavigationView: View {
    
    @State var path = NavigationPath()
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseRepository: ExerciseRepository
    let heatMapRepository: HeatMapRepository
    let userRepository: UserRepository
    
    public init(
        today: Date,
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        heatMapRepository: HeatMapRepository,
        userRepository: UserRepository
    ) {
        self.today = today
        self.historyRepository = historyRepository
        self.exerciseRepository = exerciseRepository
        self.heatMapRepository = heatMapRepository
        self.userRepository = userRepository
        coordinator = .init(path: $path)
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                today: today,
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                heatMapRepository: heatMapRepository,
                userRepository: userRepository
            )
            .navigationDestination(for: ExerciseNavigation.self) { navigation in
                switch navigation.name {
                case .manage:
                    ExerciseListView(
                        exerciseRepository: exerciseRepository) { exercise in
                            print("dg: add exercise!")
                        }
                }
            }
            .navigationDestination(for: HistoryNavigation.self) { navigation in
                switch navigation.name {
                case .heatMapColor:
                    HeatMapColorSelectView(userRepository: userRepository)
                }
            }
        }
    }
}
