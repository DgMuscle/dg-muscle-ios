//
//  ContentViewV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

enum NavigationPath: Hashable {
    case setting
    case manageExercise
    case exerciseFormStep
}

struct ContentViewV2: View {
    
    @State var paths: [NavigationPath] = []
    
    let historyViewModel: HistoryViewModel
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    let userRepository: UserRepositoryV2
    
    var body: some View {
        ZStack {
            NavigationStack(path: $paths) {
                HistoryView(viewModel: historyViewModel,
                            paths: $paths,
                            exerciseRepository: exerciseRepository,
                            healthRepository: healthRepository)
                .navigationDestination(for: NavigationPath.self) { path in
                    switch path {
                    case .setting:
                        SettingV2View(viewModel: SettingV2ViewModel(userRepository: userRepository),
                                      paths: $paths)
                    case .manageExercise:
                        ManageExerciseView(exerciseRepository: exerciseRepository,
                                           paths: $paths)
                    case .exerciseFormStep:
                        ExerciseFormStep1View(viewModel: .init(),
                                              paths: $paths,
                                              exerciseRepository: exerciseRepository)
                    }
                }
            }
        }
    }
}

#Preview {
    
    let historyRepository = HistoryRepositoryV2Test()
    let healthRepository = HealthRepositoryTest()
    let userRepository = UserRepositoryV2Test()
    let exerciseRepository = ExerciseRepositoryV2Test()
    
    let historyViewModel = HistoryViewModel(historyRepository: historyRepository,
                                            healthRepository: healthRepository,
                                            userRepository: userRepository)
    
    return ContentViewV2(historyViewModel: historyViewModel,
                         exerciseRepository: exerciseRepository,
                         healthRepository: healthRepository, 
                         userRepository: userRepository)
        .preferredColorScheme(.dark)
}
