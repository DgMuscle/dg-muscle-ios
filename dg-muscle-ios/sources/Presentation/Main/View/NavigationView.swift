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
import Rapid
import Weight
import ExerciseTimer

public struct NavigationView: View {
    
    @State var path = NavigationPath()
    @StateObject var viewModel: NavigationViewModel
    
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseTimerRepository: ExerciseTimerRepository
    let homeFactory: (Date) -> HomeView
    let exerciseListFactory: () -> ExerciseListView
    let postExerciseFactory: (Domain.Exercise?) -> PostExerciseView
    let heatMapColorSelectFactory: () -> HeatMapColorSelectView
    let postHistoryFactory: (Domain.History?) -> PostHistoryView
    let manageRecordFactory: (Binding<HistoryForm>, String) -> ManageRecordView
    let manageRunFactory: (Binding<RunPresentation>) -> ManageRunView
    let setDistanceFactory: (Double) -> SetDistanceView
    let setDurationFactory: (Int) -> SetDurationView
    let manageMemoFactory: (Binding<String>) -> ManageMemoView
    let dateToSelectHistoryFactory: () -> DateToSelectHistoryView
    let deleteAccountConfirmFactory: () -> DeleteAccountConfirmView
    let logsFactory: () -> LogsView
    let friendMainFactory: (PageAnchorView.Page) -> FriendMainView
    let friendHistoryFactory: (String, Date) -> FriendHistoryView
    let historyDetailFactory: (String, String) -> HistoryDetailView
    let manageTrainingModeFactory: () -> ManageTrainingModeView
    let rapidSearchTypeListFactory: () -> RapidSearchTypeListView
    let rapidSearchByBodyPartFactory: () -> RapidSearchByBodyPartView
    let rapidSearchByNameFactory: () -> RapidSearchByNameView
    let rapidExerciseDetailFactory: (Domain.RapidExerciseDomain) -> RapidExerciseDetailView
    let coordinatorFactory: (Binding<NavigationPath>) -> Coordinator
    let weightListFactory: () -> WeightListView
    let weightAddFactory: () -> WeightAddView
    let floatingTimerFactory: (ExerciseTimerDomain) -> FloatingTimerView
    
    public init(
        today: Date,
        historyRepository: HistoryRepository,
        exerciseTimerRepository: ExerciseTimerRepository,
        homeFactory: @escaping (Date) -> HomeView,
        exerciseListFactory: @escaping () -> ExerciseListView,
        postExerciseFactory: @escaping (Domain.Exercise?) -> PostExerciseView,
        heatMapColorSelectFactory: @escaping () -> HeatMapColorSelectView,
        postHistoryFactory: @escaping (Domain.History?) -> PostHistoryView,
        manageRecordFactory: @escaping (Binding<HistoryForm>, String) -> ManageRecordView,
        manageRunFactory: @escaping (Binding<RunPresentation>) -> ManageRunView,
        setDistanceFactory: @escaping (Double) -> SetDistanceView,
        setDurationFactory: @escaping (Int) -> SetDurationView,
        manageMemoFactory: @escaping (Binding<String>) -> ManageMemoView,
        dateToSelectHistoryFactory: @escaping () -> DateToSelectHistoryView,
        deleteAccountConfirmFactory: @escaping () -> DeleteAccountConfirmView,
        logsFactory: @escaping () -> LogsView,
        friendMainFactory: @escaping (PageAnchorView.Page) -> FriendMainView,
        friendHistoryFactory: @escaping (String, Date) -> FriendHistoryView,
        historyDetailFactory: @escaping (String, String) -> HistoryDetailView,
        manageTrainingModeFactory: @escaping () -> ManageTrainingModeView,
        rapidSearchTypeListFactory: @escaping () -> RapidSearchTypeListView,
        rapidSearchByBodyPartFactory: @escaping () -> RapidSearchByBodyPartView,
        rapidSearchByNameFactory: @escaping () -> RapidSearchByNameView,
        rapidExerciseDetailFactory: @escaping (Domain.RapidExerciseDomain) -> RapidExerciseDetailView,
        weightListFactory: @escaping () -> WeightListView,
        weightAddFactory: @escaping () -> WeightAddView,
        floatingTimerFactory: @escaping (ExerciseTimerDomain) -> FloatingTimerView,
        coordinatorFactory: @escaping (Binding<NavigationPath>) -> Coordinator
    ) {
        self.today = today
        self.historyRepository = historyRepository
        self.exerciseTimerRepository = exerciseTimerRepository
        self.homeFactory = homeFactory
        self.exerciseListFactory = exerciseListFactory
        self.postExerciseFactory = postExerciseFactory
        self.heatMapColorSelectFactory = heatMapColorSelectFactory
        self.postHistoryFactory = postHistoryFactory
        self.manageRecordFactory = manageRecordFactory
        self.manageRunFactory = manageRunFactory
        self.setDistanceFactory = setDistanceFactory
        self.setDurationFactory = setDurationFactory
        self.manageMemoFactory = manageMemoFactory
        self.dateToSelectHistoryFactory = dateToSelectHistoryFactory
        self.deleteAccountConfirmFactory = deleteAccountConfirmFactory
        self.logsFactory = logsFactory
        self.friendMainFactory = friendMainFactory
        self.friendHistoryFactory = friendHistoryFactory
        self.historyDetailFactory = historyDetailFactory
        self.manageTrainingModeFactory = manageTrainingModeFactory
        self.rapidSearchTypeListFactory = rapidSearchTypeListFactory
        self.rapidSearchByBodyPartFactory = rapidSearchByBodyPartFactory
        self.rapidSearchByNameFactory = rapidSearchByNameFactory
        self.rapidExerciseDetailFactory = rapidExerciseDetailFactory
        self.weightListFactory = weightListFactory
        self.weightAddFactory = weightAddFactory
        self.floatingTimerFactory = floatingTimerFactory
        self.coordinatorFactory = coordinatorFactory
        
        _viewModel = .init(wrappedValue: .init(exerciseTimerRepository: exerciseTimerRepository))
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            homeFactory(today)
            .navigationDestination(for: ExerciseNavigation.self) { navigation in
                switch navigation.name {
                case .manage:
                    exerciseListFactory()
                case .add(let exercise):
                    postExerciseFactory(exercise)
                }
            }
            .navigationDestination(for: HistoryNavigation.self) { navigation in
                switch navigation.name {
                case .heatMapColor:
                    heatMapColorSelectFactory()
                case .historyFormStep1(let history):
                    postHistoryFactory(history)
                case .historyFormStep2(let historyForm, let recordId):
                    manageRecordFactory(historyForm, recordId)
                case .manageRun(let run):
                    manageRunFactory(run)
                case .setDistance(let distance):
                    setDistanceFactory(distance)
                case .setDuration(let duration):
                    setDurationFactory(duration)
                case .manageMemo(let memo):
                    manageMemoFactory(memo)
                case .dateToSelectHistory:
                    dateToSelectHistoryFactory()
                case .manageTrainingMode:
                    manageTrainingModeFactory()
                }
            }
            .navigationDestination(for: MyNavigation.self) { navigation in
                switch navigation.name {
                case .deleteAccountConfirm:
                    deleteAccountConfirmFactory()
                case .logs:
                    logsFactory()
                }
            }
            .navigationDestination(for: FriendNavigation.self) { navigation in
                switch navigation.name {
                case .main(let anchor):
                    friendMainFactory(anchor)
                case .history(let friendId):
                    friendHistoryFactory(friendId, today)
                case .historyDetail(let friendId, let historyId):
                    historyDetailFactory(friendId, historyId)
                }
            }
            .navigationDestination(for: RapidNavigation.self) { navigation in
                switch navigation.name {
                case .rapidSearchTypeList:
                    rapidSearchTypeListFactory()
                case .rapidSearchByBodyPart:
                    rapidSearchByBodyPartFactory()
                case .rapidSearchByName:
                    rapidSearchByNameFactory()
                case .detail(let exercise):
                    rapidExerciseDetailFactory(exercise)
                }
            }
            .navigationDestination(for: WeightNavigation.self) { navigation in
                switch navigation.name {
                case .weightList:
                    weightListFactory()
                case .weightAdd:
                    weightAddFactory()
                }
            }
        }
        .onAppear {
            coordinator = coordinatorFactory($path)
        }
        .overlay {
            VStack {
                
                if let timer = viewModel.timer {
                    ExerciseTimer.FloatingTimerView(timer: timer)
                        .transition(.move(edge: .top))
                        .contextMenu {
                            Button("Cancel") {
                                viewModel.cancelTimer()
                            }
                        }
                        .padding(.top, 40)
                }
                
                Spacer()
            }
            .animation(.default, value: viewModel.timer)
        }
    }
}
