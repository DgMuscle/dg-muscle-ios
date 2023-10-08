//
//  DependencyInjection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI
import Foundation

final class DependencyInjection {
    static let shared = DependencyInjection()
    
    private init () { }
    
    func setting(paths: Binding<[ContentView.NavigationPath]>) -> SettingViewDependency {
        SettingViewDependencyImpl(paths: paths)
    }
    
    func bodyProfile(paths: Binding<[ContentView.NavigationPath]>,
                     isShowingProfilePhotoPicker: Binding<Bool>,
                     errorMessage: Binding<String?>,
                     isShowingErrorView: Binding<Bool>
    ) -> BodyProfileViewDependency {
        return BodyProfileViewDependencyImpl(
            paths: paths,
            isShowingProfilePhotoPicker: isShowingProfilePhotoPicker,
            errorMessage: errorMessage,
            isShowingErrorView: isShowingErrorView
        )
    }
    
    func profilePhotoPicker() -> PhotoPickerViewDependency {
        ProfilePhotoPickerDependencyImpl()
    }
    
    func displayNameTextInput() -> SimpleTextInputDependency {
        DisplayNameTextInputDependencyImpl()
    }
    
    func withdrawalConfirm(errorMessage: Binding<String?>, isShowingErrorView: Binding<Bool>) -> WithdrawalConfirmDependency {
        WithdrawalConfirmDependencyImpl(errorMessage: errorMessage, isShowingErrorView: isShowingErrorView)
    }
    
    func exerciseDiary(paths: Binding<[ContentView.NavigationPath]>) -> ExerciseDiaryDependency {
        ExerciseDiaryDependencyImpl(paths: paths)
    }
    
    func historyForm(isShowingErrorView: Binding<Bool>, errorMessage: Binding<String?>, paths: Binding<[ContentView.NavigationPath]>) -> HistoryFormDependency {
        return HistoryFormDependencyImpl(isShowingErrorView: isShowingErrorView, errorMessage: errorMessage, paths: paths)
    }
    
    func recordForm(paths: Binding<[ContentView.NavigationPath]>) -> RecordFormDependency {
        RecordFormDependencyImpl(paths: paths)
    }
    
    func exerciseForm(paths: Binding<[ContentView.NavigationPath]>) -> ExerciseFormDependency {
        ExerciseFormDependencyImpl(paths: paths)
    }
    
    func setForm(paths: Binding<[ContentView.NavigationPath]>) -> SetFormViewDependency {
        SetFormViewDependencyImpl(paths: paths)
    }
    
    func exerciseList(
        paths: Binding<[ContentView.NavigationPath]>,
        errorMessage: Binding<String?>,
        isShowingErrorView: Binding<Bool>
    ) -> ExerciseListViewDependency {
        ExerciseListViewDependencyImpl(paths: paths, errorMessage: errorMessage, isShowingErrorView: isShowingErrorView)
    }
}

struct ExerciseListViewDependencyImpl: ExerciseListViewDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    @Binding var errorMessage: String?
    @Binding var isShowingErrorView: Bool
    
    func tapAdd() {
        paths.append(.exerciseForm)
    }
    
    func tapSave(exercises: [Exercise]) {
        Task {
            let _ = paths.popLast()
            store.exercise.set(exercises: exercises)
            let response = try await ExerciseRepository.shared.set(exercises: exercises)
            store.exercise.updateExercises()
            
            if let errorMessage = response.message {
                withAnimation {
                    self.errorMessage = errorMessage
                    self.isShowingErrorView = true
                }
            }
        }
    }
}

struct SetFormViewDependencyImpl: SetFormViewDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    
    func save(data: ExerciseSet) {
        let _ = paths.popLast()
        RecordFormNotificationCenter.shared.set = data
    }
}

struct ExerciseFormDependencyImpl: ExerciseFormDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    
    func tapSave(data: Exercise) {
        let _ = paths.popLast()
        ExerciseListViewNotificationCenter.shared.exercise = data
        Task {
            store.exercise.append(exercise: data)
            let _ = try await ExerciseRepository.shared.post(data: data)
            store.exercise.updateExercises()
            
        }
    }
}

struct RecordFormDependencyImpl: RecordFormDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    
    func addExercise() {
        paths.append(.exerciseForm)
    }
    
    func addSet() {
        paths.append(.setForm)
    }
    
    func save(record: Record) {
        let _ = paths.popLast()
        HistoryFormNotificationCenter.shared.record = record
    }
    
    func tapPreviusRecordButton(record: Record, dateString: String) {
        paths.append(.recordSets(record, dateString))
    }
}

struct HistoryFormDependencyImpl: HistoryFormDependency {
    
    @Binding var isShowingErrorView: Bool
    @Binding var errorMessage: String?
    @Binding var paths: [ContentView.NavigationPath]
    
    func tap(record: Record, dateString: String) {
        let exercise = store.exercise.exercises.first(where: { $0.id == record.exerciseId })
        paths.append(.recordForm(exercise, record.sets, dateString))
    }
    
    func tapAdd(dateString: String) {
        paths.append(.recordForm(nil, [], dateString))
    }
    
    func tapSave(data: ExerciseHistory) {
        Task {
            do {
                let _ = paths.popLast()
                withAnimation {
                    if let index = store.history.histories.firstIndex(of: data) {
                        store.history.histories[index] = data
                    } else {
                        store.history.histories.insert(data, at: 0)
                    }
                }
                let _ = try await HistoryRepository.shared.post(data: data)
                store.history.updateHistories()
            } catch {
                DispatchQueue.main.async {
                    withAnimation {
                        self.errorMessage = error.localizedDescription
                        self.isShowingErrorView = true
                    }
                }
            }
        }
    }
}

struct ExerciseDiaryDependencyImpl: ExerciseDiaryDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    
    func tapAddHistory() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: Date())
        
        if let history = store.history.histories.first(where: { $0.date == dateString }) {
            paths.append(.historyForm(history.id, history.date, history.records))
        } else {
            paths.append(.historyForm(nil, nil, []))
        }
    }
    
    func tapHistory(history: ExerciseHistory) {
        paths.append(.historyForm(history.id, history.date, history.records))
    }
    
    func scrollBottom() {
        store.history.appendHistories()
    }
    
    func delete(data: ExerciseHistory) {
        Task {
            let _ = try await HistoryRepository.shared.delete(data: data)
            store.history.updateHistories()
        }
    }
}

struct WithdrawalConfirmDependencyImpl: WithdrawalConfirmDependency {
    
    @Binding var errorMessage: String?
    @Binding var isShowingErrorView: Bool
    
    func delete() {
        Task {
            if let error = await Authenticator().withDrawal() {
                DispatchQueue.main.async {
                    withAnimation {
                        self.errorMessage = error.localizedDescription
                        self.isShowingErrorView = true
                    }
                }
            }
            store.user.updateUser()
        }
    }
}

struct DisplayNameTextInputDependencyImpl: SimpleTextInputDependency {
    func save(text: String) {
        Task {
            try await Authenticator().updateUser(displayName: text.isEmpty ? nil : text, photoURL: store.user.photoURL)
            store.user.updateUser()
        }
    }
}

struct ProfilePhotoPickerDependencyImpl: PhotoPickerViewDependency {
    func saveProfileImage(image: UIImage?) {
        Task {
            guard let uid = store.user.uid else { throw CustomError.authentication }
            
            if let previousPhotoURLString = store.user.photoURL?.absoluteString, let path = URL(string: previousPhotoURLString)?.lastPathComponent {
                try await FileUploader.shared.deleteImage(path: "profilePhoto/\(uid)/\(path)")
                try await Authenticator().updateUser(displayName: store.user.displayName, photoURL: nil)
            }
            
            if let image {
                let url = try await FileUploader.shared.uploadImage(path: "profilePhoto/\(uid)/\(UUID().uuidString).png", image: image)
                try await Authenticator().updateUser(displayName: store.user.displayName, photoURL: url)
            }
            
            store.user.updateUser()
        }
    }
}

struct BodyProfileViewDependencyImpl: BodyProfileViewDependency {
    
    @Binding var paths: [ContentView.NavigationPath]
    @Binding var isShowingProfilePhotoPicker: Bool
    @Binding var errorMessage: String?
    @Binding var isShowingErrorView: Bool
    
    func tapSave(displayName: String, height: Double, weight: Double) {
        Task {
            let _ = paths.popLast()
            guard let id = store.user.uid else { return }
            
            var profile = Profile(id: id, photoURL: store.user.photoURL?.absoluteString, displayName: displayName, specs: store.user.profile?.specs ?? [], updatedAt: nil)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let createdAt = dateFormatter.string(from: Date())
            
            profile.specs = profile.specs.filter({ $0.createdAt != createdAt })
            profile.specs.append(.init(height: height, weight: weight, createdAt: createdAt))
            
            store.user.set(displayName: displayName, profile: profile)
            
            try await Authenticator().updateUser(displayName: displayName.isEmpty ? nil : displayName, photoURL: store.user.photoURL)
            let response = try await UserRepository.shared.postProfile(profile: profile)
            
            store.user.updateUser()
            
            if let errorMessage = response.message {
                withAnimation {
                    self.errorMessage = errorMessage
                    self.isShowingErrorView = true
                }
            }
        }
    }
    
    func tapProfileImage() {
        withAnimation {
            isShowingProfilePhotoPicker = true
        }
    }
}

struct SettingViewDependencyImpl: SettingViewDependency {
    @Binding var paths: [ContentView.NavigationPath]
    
    func tapProfileSection() {
        paths.append(.bodyProfile)
    }
    
    func tapExercise() {
        paths.append(.exerciseList)
    }
}
