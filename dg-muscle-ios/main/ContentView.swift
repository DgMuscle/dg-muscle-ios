//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var paths: [NavigationPath] = []
    
    @State var isShowingProfilePhotoPicker = false
    @State var isPresentedWithDrawalConfirm = false
    @State var loadingState = LoadingState(showing: false)
    @State var showingErrorState = ShowingErrorState(showing: false, message: "")
    @State var showingSuccessState = ShowingSuccessState(showing: false, message: "")
    @State var monthlyChartViewIngredient: MonthlyChartViewIngredient = .init()
    
    @StateObject var userStore = store.user
    @StateObject var healthStore = store.health
    
    var body: some View {
        ZStack {
            if userStore.login {
                NavigationStack(path: $paths) {
                    ExerciseDiaryView(dependency: DependencyInjection.shared.exerciseDiary(paths: $paths, monthlyChartViewIngredient: $monthlyChartViewIngredient), bodyMass: healthStore.recentBodyMass)
                    .navigationDestination(for: NavigationPath.self) { path in
                        switch path {
                        case .historyForm(let history):
                            
                            let validRecords = history.records.filter({ record in
                                store.exercise.exercises.contains(where: { $0.id == record.exerciseId })
                            })
                            
                            HistoryFormView(dependency: DependencyInjection.shared.historyForm(showingErrorState: $showingErrorState, paths: $paths),
                                            history: history,
                                            saveButtonDisabled: validRecords.isEmpty)
                        case .recordForm(let selectedExercise, let sets, let dateString):
                            RecordFormView(
                                selectedExercise: selectedExercise,
                                sets: sets,
                                dependency: DependencyInjection.shared.recordForm(paths: $paths),
                                dateString: dateString
                            )
                        case .exerciseForm(let id, let order, let name, let parts, let favorite):
                            ExerciseFormView(
                                dependency: DependencyInjection.shared.exerciseForm(paths: $paths,
                                                                                    showingErrorState: $showingErrorState,
                                                                                    showingSuccessState: $showingSuccessState,
                                                                                    loadingState: $loadingState),
                                id: id,
                                order: order,
                                name: name,
                                selectedParts: parts,
                                favorite: favorite,
                                saveButtonVisible: !name.isEmpty)
                        case .setForm:
                            SetFormView(
                                dependency: DependencyInjection.shared.setForm(paths: $paths),
                                unit: .kg,
                                reps: 0,
                                weight: 0
                            )
                        case .bodyProfile:
                            BodyProfileView(
                                dependency: DependencyInjection.shared.bodyProfile(paths: $paths,
                                                                                   isShowingProfilePhotoPicker: $isShowingProfilePhotoPicker,
                                                                                   showingErrorState: $showingErrorState)
                            )
                        case .exerciseList:
                            ExerciseListView(
                                dependency: DependencyInjection.shared.exerciseList(paths: $paths,
                                                                                    showingErrorState: $showingErrorState,
                                                                                    showingSuccessState: $showingSuccessState,
                                                                                    loadingState: $loadingState),
                                exercises: store.exercise.exercises
                            )
                        case .recordSets(let record, let dateString):
                            RecordSetsView(record: record, dateString: dateString)
                        case .selectExercise:
                            SelectExerciseView(dependency: DependencyInjection.shared.selectExercise(paths: $paths))
                        case .setting:
                            SettingView(
                                dependency:
                                    DependencyInjection.shared.setting(paths: $paths,
                                                                       isPresentedWithDrawalConfirm: $isPresentedWithDrawalConfirm)
                            )
                        case .watchWorkoutAppInfoView:
                            WatchWorkoutAppInfoView()
                        case .exerciseGuideList:
                            ExerciseGuideListView(dependency: DependencyInjection.shared.exerciseGuideInfo(paths: $paths))
                        case .memo(text: let memo):
                            MemoView(dependency: DependencyInjection.shared.memoFromHistoryForm(paths: $paths), memo: memo)
                        case .exerciseInfo(let type):
                            let dp = DependencyInjection.shared.exerciseInfoContainer(paths: $paths,
                                                                                      loadingState: $loadingState,
                                                                                      showingErrorState: $showingErrorState,
                                                                                      showingSuccessState: $showingSuccessState)
                            ExerciseInfoContainerView(type: type, dependency: dp)
                        case .guide:
                            GuideView()
                        }
                    }
                }
                .sheet(isPresented: $isPresentedWithDrawalConfirm, content: {
                    WithdrawalConfirmView(
                        isPresented: $isPresentedWithDrawalConfirm,
                        dependency: DependencyInjection.shared.withdrawalConfirm(showingErrorState: $showingErrorState))
                })
                .sheet(isPresented: $isShowingProfilePhotoPicker) {
                    PhotoPickerView(uiImage: userStore.photoUiImage,
                                    isShowing: $isShowingProfilePhotoPicker,
                                    dependency: DependencyInjection.shared.profilePhotoPicker(loadingState: $loadingState,
                                                                                              showingSuccessState: $showingSuccessState,
                                                                                              showingErrorState: $showingErrorState))
                    .presentationDetents([.large, .medium])
                }
                .sheet(isPresented: $monthlyChartViewIngredient.showing, content: {
                    MonthlyChartView(
                        histories: monthlyChartViewIngredient.exerciseHistories,
                        volumeByPart: monthlyChartViewIngredient.volumeBasedOnExercise,
                        showing: $monthlyChartViewIngredient.showing)
                })
                
            } else {
                SignInView()
            }
            
            if showingErrorState.showing {
                ErrorView(message: showingErrorState.message, isShowing: $showingErrorState.showing)
            }
            
            if showingSuccessState.showing {
                SuccessView(isShowing: $showingSuccessState.showing, message: showingSuccessState.message)
            }
            
            if loadingState.showing {
                LoadingView(message: loadingState.message)
            }
        }
        .onAppear {
            Task {
                do {
                    try await store.health.requestAuthorization()
                    store.health.fetch()
                } catch {
                    withAnimation {
                        showingErrorState = .init(showing: true, message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension ContentView {
    enum NavigationPath: Hashable {
        case historyForm(ExerciseHistory)
        case recordForm(Exercise?, [ExerciseSet], String)
        case exerciseForm(String?, Int?, String, [Exercise.Part], Bool)
        case setForm
        case bodyProfile
        case exerciseList
        case recordSets(Record, String)
        case selectExercise
        case setting
        case watchWorkoutAppInfoView
        case exerciseGuideList
        case memo(text: String)
        case exerciseInfo(ExerciseInfoContainerView.ExerciseType)
        case guide
        
        func hash(into hasher: inout Hasher) {
            
        }
    }
}

extension ContentView {
    struct MonthlyChartViewIngredient {
        var showing: Bool = false
        var exerciseHistories: [ExerciseHistory] = []
        var volumeBasedOnExercise: [String: Double] = [:]
    }
}

extension ContentView {
    struct ShowingErrorState {
        var showing: Bool
        var message: String
    }
    
    struct ShowingSuccessState {
        var showing: Bool
        var message: String
    }
    
    struct LoadingState {
        var showing: Bool
        var message: String?
    }
}
