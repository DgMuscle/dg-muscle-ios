//
//  ContentViewV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ContentViewV2: View {
    
    @State var path: NavigationPath = .init()
    @StateObject var viewModel: ContentViewV2Model
    
    let historyViewModel: HistoryViewModel
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    let userRepository: UserRepositoryV2
    let historyRepository: HistoryRepositoryV2
    let today: Date
    let appleAuth: AppleAuth
    let fileUploader: FileUploaderInterface
    let heatmapRepository: HeatmapRepository
    
    var body: some View {
        ZStack {
            if viewModel.isLogin == false {
                AppleAuthView(viewModel: .init(appleAuth: appleAuth))
            } else {
                NavigationStack(path: $path) {
                    HistoryView(viewModel: historyViewModel,
                                exerciseRepository: exerciseRepository,
                                healthRepository: healthRepository,
                                historyRepository: historyRepository, 
                                heatmapRepository: heatmapRepository,
                                today: today
                    )
                    .navigationDestination(for: MainNavigation.self) { navigation in
                        switch navigation.name {
                        case .setting:
                            SettingV2View(viewModel: SettingV2ViewModel(userRepository: userRepository))
                        case .profile:
                            MyProfileView(viewModel: .init(userRepository: userRepository,
                                                           healthRepository: healthRepository))
                        case .editProfilePhoto:
                            UpdateProfilePhotoView(viewModel: .init(userRepository: userRepository,
                                                                    fileUploader: fileUploader))
                        case .selectHeatmapColor:
                            HeatmapColorSelectionView(viewModel: .init(heatmapRepository: heatmapRepository))
                        case .openWeb:
                            if let ingredient = navigation.openWebIngredient {
                                OpenWeb(url: ingredient.url)
                            }
                        }
                    }
                    .navigationDestination(for: HistoryNavigation.self, destination: { navigation in
                        switch navigation.name {
                        case .historyForm:
                            HistoryFormV2View(viewModel: .init(history:
                                                                navigation.historyForForm ??
                                                               ExerciseHistory(id: UUID().uuidString,
                                                                               date: todayDateString(),
                                                                               memo: nil,
                                                                               records: [],
                                                                               createdAt: nil),
                                                               historyRepository: historyRepository),
                                              exerciseRepository: exerciseRepository)
                        case .recordForm:
                            
                            if let ingredient = navigation.recordFornIngredient {
                                RecordFormV2View(viewModel: .init(record: ingredient.recordForForm,
                                                                  exerciseRepository: exerciseRepository,
                                                                  historyRepository: historyRepository,
                                                                  date: ingredient.dateForRecordForm, 
                                                                  startTimeInterval: ingredient.startTimeInterval))
                            }
                        case .monthlySection:
                            if let ingredient = navigation.monthlySectionIngredient {
                                MonthlySectionView(viewModel: .init(exerciseHistorySection: ingredient,
                                                                    exerciseRepository: exerciseRepository))
                            }
                        }
                    })
                    .navigationDestination(for: ExerciseNavigation.self) { navigation in
                        switch navigation.name {
                        case .manage:
                            ManageExerciseView(viewModel: .init(exerciseRepository: exerciseRepository),
                                               paths: $path)
                        case .edit:
                            if let exercise = navigation.editIngredient {
                                EditExerciseView(viewModel: .init(exercise: exercise,
                                                                  exerciseRepository: exerciseRepository,
                                                                  completeAction: nil))
                            }
                        case .step1:
                            ExerciseFormStep1View(viewModel: .init(),
                                                  paths: $path,
                                                  exerciseRepository: exerciseRepository)
                        case .step2:
                            if let dependency = navigation.step2Depndency {
                                ExerciseFormStep2View(viewModel: .init(name: dependency.name,
                                                                       parts: dependency.parts,
                                                                       exerciseRepository: exerciseRepository,
                                                                       completeAction: {
                                    path.removeLast(2)
                                }))
                            }
                        }
                    }
                }
            }
        }
        .animation(.default, value: viewModel.isLogin)
        .environmentObject(Coordinator(path: $path))
    }
    
    private func todayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyMMdd"
        return dateFormatter.string(from: Date())
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
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240415")!
    
    return ContentViewV2(viewModel: .init(userRepository: userRepository),
                         historyViewModel: historyViewModel,
                         exerciseRepository: exerciseRepository,
                         healthRepository: healthRepository, 
                         userRepository: userRepository, 
                         historyRepository: historyRepository, 
                         today: today, 
                         appleAuth: AppleAuthTest(), 
                         fileUploader: FileUploaderTest(), 
                         heatmapRepository: HeatmapRepositoryTest())
        .preferredColorScheme(.dark)
}
