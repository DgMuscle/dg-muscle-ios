//
//  NavigationView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct NavigationView: View {
    
    @EnvironmentObject var coordinator: CoordinatorV2
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseRepository: ExerciseRepository
    let healthRepository: HealthRepositoryDomain
    let userRepository: UserRepository
    let authenticator: AuthenticatorInterface
    let fileUploader: FileUploaderInterface
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HistoryListView(today: today,
                            historyRepository: historyRepository,
                            exerciseRepository: exerciseRepository,
                            healthRepository: healthRepository,
                            viewModel: .init(subscribeGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                             subscribeMetaDatasMapUsecase: .init(healthRepository: healthRepository),
                                             subscribeUserUsecase: .init(userRepository: userRepository),
                                             getTodayHistoryUsecase: .init(historyRepository: historyRepository, today: today),
                                             deleteHistoryUsecase: .init(historyRepository: historyRepository)))
            .navigationDestination(for: MainNavigationV2.self) { navigation in
                switch navigation.name {
                case .setting:
                    SettingView(viewModel: .init(subscribeUserUsecase: .init(userRepository: userRepository),
                                                 signOutUsecase: .init(authenticator: authenticator),
                                                 deleteAccountUsecase: .init(authenticator: authenticator)),
                                getUserUsecase: .init(userRepository: userRepository))
                case .profile:
                    ProfileEditView(viewModel: .init(postUserDisplayNameUsecase: .init(userRepository: userRepository),
                                                     subscribeUserUsecase: .init(userRepository: userRepository)),
                                    healthRepository: healthRepository)
                case .profilePhoto:
                    ProfilePhotoEditView(viewModel: .init(postUserProfileImageUsecase: .init(userRepository: userRepository,
                                                                                             fileUploader: fileUploader),
                                                          deleteUserProfileImageUsecase: .init(userRepository: userRepository,
                                                                                               fileUploader: fileUploader),
                                                          getUserUsecase: .init(userRepository: userRepository)))
                case .openWeb:
                    if let url = navigation.openWebUrl {
                        DGWebViewPresenter(url: url)
                    }
                case .heatmapColor:
                    HeatmapView(viewModel: .init(subscribeHeatmapUsecase: .init(historyRepository: historyRepository,
                                                                                today: today),
                                                 subscribeHeatmapColorUsecase: .init(historyRepository: historyRepository)))
                }
            }
            .navigationDestination(for: HistoryNavigationV2.self) { navigation in
                switch navigation.name {
                case .historyForm:
                    if let history = navigation.historyFormParameter {
                        HistoryFormRecordsView(viewModel: .init(history: history,
                                                                postHistoryUsecase: .init(historyRepository: historyRepository)),
                                               exerciseRepository: exerciseRepository)
                    }
                case .recordForm:
                    if let record = navigation.recordForForm, let date = navigation.historyDateForForm {
                        HistoryFormSetsView(viewModel: .init(record: record,
                                                             historyDate: date,
                                                             getPreviousRecordUsecase: .init(historyRepository: historyRepository),
                                                             getExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    }
                }
            }
            .navigationDestination(for: ExerciseNavigationV2.self) { navigation in
                switch navigation.name {
                case .manage:
                    ExerciseManageView(exerciseRepository: exerciseRepository,
                                       viewModel: .init(deleteExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                case .edit:
                    if let exercise = navigation.edit {
                        ExerciseEditView(viewModel: .init(exercise: exercise,
                                                          editExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    }
                case .add1:
                    ExerciseAdd1View(viewModel: .init())
                case .add2:
                    if let name = navigation.exerciseName {
                        ExerciseAdd2View(viewModel: .init(name: name,
                                                          parts: navigation.exerciseParts,
                                                          postExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    }
                }
            }
        }
    }
}
