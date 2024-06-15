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
import My
import Friend

public struct NavigationView: View {
    
    @State var path = NavigationPath()
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseRepository: ExerciseRepository
    let heatMapRepository: HeatMapRepository
    let userRepository: UserRepository
    let friendRepository: FriendRepository
    
    public init(
        today: Date,
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        heatMapRepository: HeatMapRepository,
        userRepository: UserRepository,
        friendRepository: FriendRepository
    ) {
        self.today = today
        self.historyRepository = historyRepository
        self.exerciseRepository = exerciseRepository
        self.heatMapRepository = heatMapRepository
        self.userRepository = userRepository
        self.friendRepository = friendRepository
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
                            coordinator?.addExercise(exercise: exercise)
                        }
                case .add(let exercise):
                    PostExerciseView(exercise: exercise,
                                     exerciseRepository: exerciseRepository) {
                        coordinator?.pop()
                    }
                }
            }
            .navigationDestination(for: HistoryNavigation.self) { navigation in
                switch navigation.name {
                case .heatMapColor:
                    HeatMapColorSelectView(userRepository: userRepository)
                case .historyFormStep1(let history):
                    PostHistoryView(
                        historyRepository: historyRepository,
                        exerciseRepository: exerciseRepository,
                        userRepository: userRepository,
                        history: history) { historyForm, recordId in
                            coordinator?.historyFormStep2(historyForm: historyForm, recordId: recordId)
                        } runAction: { run in
                            coordinator?.historyManageRun(run: run)
                        }
                case .historyFormStep2(let historyForm, let recordId):
                    ManageRecordView(
                        historyForm: historyForm,
                        recordId: recordId,
                        userRepository: userRepository, 
                        historyRepository: historyRepository
                    )
                case .manageRun(let run):
                    ManageRunView(run: run)
                }
            }
            .navigationDestination(for: MyNavigation.self) { navigation in
                switch navigation.name {
                case .profile:
                    My.MyProfileView(userRepository: userRepository)
                }
            }
            .navigationDestination(for: FriendNavigation.self) { navigation in
                switch navigation.name {
                case .main(let anchor):
                    Friend.FriendMainView(
                        friendRepository: friendRepository,
                        userRepository: userRepository, 
                        page: anchor
                    )
                case .history(let friendId):
                    Friend.FriendHistoryView(
                        friendRepository: friendRepository,
                        friendId: friendId, 
                        today: today
                    )
                case .historyDetail(let friendId, let historyId):
                    Friend.HistoryDetailView(
                        friendRepository: friendRepository,
                        friendId: friendId,
                        historyId: historyId
                    )
                }
            }
        }
        .onAppear {
            coordinator = .init(
                path: $path,
                historyRepository: historyRepository
            )
        }
    }
}
