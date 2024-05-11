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
    let heatmapRepository: HeatmapRepository
    let friendRepository: FriendRepository
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HistoryListView(today: today,
                            historyRepository: historyRepository,
                            exerciseRepository: exerciseRepository,
                            healthRepository: healthRepository, 
                            heatmapRepository: heatmapRepository,
                            viewModel: .init(subscribeGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                             subscribeMetaDatasMapUsecase: .init(healthRepository: healthRepository),
                                             subscribeUserUsecase: .init(userRepository: userRepository),
                                             getTodayHistoryUsecase: .init(historyRepository: historyRepository, today: today),
                                             deleteHistoryUsecase: .init(historyRepository: historyRepository),
                                             getHeatmapColorUsecase: .init(heatMapRepository: heatmapRepository),
                                             subscribeHeatmapColorUsecase: .init(heatmapRepository: heatmapRepository),
                                             getExercisesUsecase: .init(exerciseRepository: exerciseRepository)
                                            ))
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
                        WebView(url: url)
                    }
                case .heatmapColor:
                    HeatmapColorView(viewModel: .init(postHeatmapColorUsecase: .init(heatmapRepository: heatmapRepository),
                                                      subscribeHeatmapColorUsecase: .init(heatmapRepository: heatmapRepository),
                                                      getHeatmapColorUsecase: .init(heatMapRepository: heatmapRepository)))
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
                    if let record = navigation.recordForForm?.0, let date = navigation.recordForForm?.1 {
                        HistoryFormSetsView(viewModel: .init(record: record,
                                                             historyDate: date,
                                                             getPreviousRecordUsecase: .init(historyRepository: historyRepository),
                                                             getExerciseUsecase: .init(exerciseRepository: exerciseRepository)))
                    }
                case .previousRecord:
                    if let parameter = navigation.previousRecord {
                        PreviousRecordHistoryView(viewModel: .init(record: parameter.0,
                                                                   date: parameter.1,
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
            .navigationDestination(for: FriendNavigation.self) { navigation in
                switch navigation.name {
                case .list:
                    FriendListView(viewModel: .init(getMyFriendsUsecase: .init(friendRepository: friendRepository), 
                                                    subscribeFriendRequestsUsecase: .init(friendRepository: friendRepository)))
                case .search:
                    UsersSearchView(viewModel: .init(searchUsersByDisplayNameUsecase: .init(userRepository: userRepository),
                                                     getMyFriendsUsecase: .init(friendRepository: friendRepository),
                                                     getUserUsecase: .init(userRepository: userRepository),
                                                     postFriendRequestUsecase: .init(friendRepository: friendRepository)))
                case .requestList:
                    FriendRequestListView(viewModel: .init(subscribeFriendRequestsUsecase: .init(friendRepository: friendRepository),
                                                           acceptFriendUsecase: .init(friendRepository: friendRepository),
                                                           refuseFriendUsecase: .init(friendRepository: friendRepository),
                                                           getUserFromUserIdUsecase: .init(userRepository: userRepository),
                                                           updateFriendsUsecase: .init(friendRepository: friendRepository)))
                case .historyList:
                    if let historyList = navigation.historyList {
                        FriendHistoryListView(viewModel: .init(friend: historyList.0,
                                                               getFriendGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                                               getHistoriesFromUidUsecase: .init(historyRepository: historyRepository),
                                                               generateHeatmapFromHistoryUsecase: .init(today: historyList.1),
                                                               getFriendExercisesUsecase: .init(exerciseRepository: exerciseRepository)))
                    }
                }
            }
        }
    }
}
