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
    @State var isShowingErrorView = false

    @State var errorMessage: String?
    
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                NavigationStack(path: $paths) {
                    TabView(
                        settingViewDependency: DependencyInjection.shared.setting(paths: $paths),
                        exerciseDiaryDependency: DependencyInjection.shared.exerciseDiary(paths: $paths)
                    )
                    .navigationDestination(for: NavigationPath.self) { path in
                        switch path {
                        case .historyForm(let id, let dateString, let records):
                            
                            let validRecords = records.filter({ record in
                                store.exercise.exercises.contains(where: { $0.id == record.exerciseId })
                            })
                            
                            HistoryFormView(
                                dependency:
                                    DependencyInjection.shared.historyForm(isShowingErrorView: $isShowingErrorView, errorMessage: $errorMessage, paths: $paths),
                                id: id,
                                dateString: dateString,
                                records: records,
                                saveButtonDisabled: validRecords.isEmpty
                            )
                        case .recordForm(let selectedExercise, let sets, let dateString):
                            RecordFormView(
                                selectedExercise: selectedExercise,
                                sets: sets,
                                dependency: DependencyInjection.shared.recordForm(paths: $paths),
                                dateString: dateString
                            )
                        case .exerciseForm(let id, let order, let name, let parts, let favorite):
                            ExerciseFormView(
                                dependency: DependencyInjection.shared.exerciseForm(paths: $paths),
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
                                dependency: DependencyInjection.shared.bodyProfile(
                                    paths: $paths,
                                    isShowingProfilePhotoPicker: $isShowingProfilePhotoPicker,
                                    errorMessage: $errorMessage,
                                    isShowingErrorView: $isShowingErrorView
                                )
                            )
                        case .exerciseList:
                            ExerciseListView(
                                dependency: DependencyInjection.shared.exerciseList(
                                    paths: $paths,
                                    errorMessage: $errorMessage,
                                    isShowingErrorView: $isShowingErrorView
                                ),
                                exercises: store.exercise.exercises
                            )
                        case .recordSets(let record, let dateString):
                            RecordSetsView(record: record, dateString: dateString)
                        }
                    }
                }
                .sheet(isPresented: $isPresentedWithDrawalConfirm, content: {
                    WithdrawalConfirmView(
                        isPresented: $isPresentedWithDrawalConfirm,
                        dependency: DependencyInjection.shared.withdrawalConfirm(errorMessage: $errorMessage, isShowingErrorView: $isShowingErrorView))
                })
                
                if isShowingProfilePhotoPicker {
                    PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingProfilePhotoPicker, dependency: DependencyInjection.shared.profilePhotoPicker())
                }
                
            } else {
                SignInView()
            }
            
            if isShowingErrorView {
                ErrorView(message: errorMessage ?? "unknown error", isShowing: $isShowingErrorView)
            }
        }
    }
}

extension ContentView {
    enum NavigationPath: Hashable {
        case historyForm(String?, String?, [Record])
        case recordForm(Exercise?, [ExerciseSet], String)
        case exerciseForm(String?, Int?, String, [Exercise.Part], Bool)
        case setForm
        case bodyProfile
        case exerciseList
        case recordSets(Record, String)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .historyForm(let value, _, _):
                hasher.combine(value)
            case .recordForm(let value, _, _):
                hasher.combine(value)
            case .recordSets(let value, _):
                hasher.combine(value)
            case .exerciseForm, .setForm, .bodyProfile, .exerciseList: break
            }
        }
    }
}
