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
    @State var isShowingDisplayName = false
    @State var isPresentedWithDrawalConfirm = false
    @State var isShowingErrorView = false

    @State var error: Error?
    
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                NavigationStack(path: $paths) {
                    TabView(
                        settingViewDependency: DependencyInjection.shared.setting(
                            isShowingProfilePhotoPicker: $isShowingProfilePhotoPicker,
                            isShowingDisplayName: $isShowingDisplayName,
                            isPresentedWithDrawalConfirm: $isPresentedWithDrawalConfirm),
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
                                    DependencyInjection.shared.historyForm(isShowingErrorView: $isShowingErrorView, error: $error, paths: $paths),
                                id: id,
                                dateString: dateString,
                                records: records,
                                saveButtonDisabled: validRecords.isEmpty
                            )
                        case .recordForm(let selectedExercise, let sets):
                            RecordFormView(selectedExercise: selectedExercise, sets: sets, dependency: DependencyInjection.shared.recordForm(paths: $paths))
                        case .exerciseForm:
                            ExerciseFormView(
                                dependency: DependencyInjection.shared.exerciseForm(paths: $paths),
                                name: "",
                                selectedParts: [],
                                favorite: false,
                                saveButtonVisible: false)
                        case .setForm:
                            SetFormView(
                                dependency: DependencyInjection.shared.setForm(paths: $paths),
                                unit: .kg,
                                reps: 0,
                                weight: 0
                            )
                        }
                    }
                }
                .sheet(isPresented: $isPresentedWithDrawalConfirm, content: {
                    WithdrawalConfirmView(
                        isPresented: $isPresentedWithDrawalConfirm,
                        dependency: DependencyInjection.shared.withdrawalConfirm(error: $error, isShowingErrorView: $isShowingErrorView))
                })
                
                if isShowingProfilePhotoPicker {
                    PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingProfilePhotoPicker, dependency: DependencyInjection.shared.profilePhotoPicker())
                }
                
                if isShowingDisplayName {
                    SimpleTextInputView(text: store.user.displayName ?? "", isShowing: $isShowingDisplayName, placeholder: "display name", dependency: DependencyInjection.shared.displayNameTextInput())
                }
                
            } else {
                SignInView()
            }
            
            if isShowingErrorView {
                ErrorView(message: error?.localizedDescription ?? "unknown error", isShowing: $isShowingErrorView)
            }
        }
    }
}

extension ContentView {
    enum NavigationPath: Hashable {
        case historyForm(String?, String?, [Record])
        case recordForm(Exercise?, [ExerciseSet])
        case exerciseForm
        case setForm
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .historyForm(let value, _, _):
                hasher.combine(value)
            case .recordForm(let value, _):
                hasher.combine(value)
            case .exerciseForm, .setForm: break
            }
        }
    }
}
