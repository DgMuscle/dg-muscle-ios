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
    
    func setting(
        isShowingProfilePhotoPicker: Binding<Bool>,
        isShowingDisplayName: Binding<Bool>,
        isPresentedWithDrawalConfirm: Binding<Bool>
    ) -> SettingViewDependency {
        SettingViewDependencyImpl(
            isShowingProfilePhotoPicker: isShowingProfilePhotoPicker,
            isShowingDisplayName: isShowingDisplayName,
            isPresentedWithDrawalConfirm: isPresentedWithDrawalConfirm
        )
    }
    
    func profilePhotoPicker() -> PhotoPickerViewDependency {
        ProfilePhotoPickerDependencyImpl()
    }
    
    func displayNameTextInput() -> SimpleTextInputDependency {
        DisplayNameTextInputDependencyImpl()
    }
    
    func withdrawalConfirm(error: Binding<Error?>, isShowingErrorView: Binding<Bool>) -> WithdrawalConfirmDependency {
        WithdrawalConfirmDependencyImpl(error: error, isShowingErrorView: isShowingErrorView)
    }
    
    func exerciseDiary(paths: Binding<[ContentView.NavigationPath]>) -> ExerciseDiaryDependency {
        ExerciseDiaryDependencyImpl(paths: paths)
    }
    
    func historyForm(isShowingErrorView: Binding<Bool>, error: Binding<Error?>) -> HistoryFormDependency {
        return HistoryFormDependencyImpl(isShowingErrorView: isShowingErrorView, error: error)
    }
}

struct HistoryFormDependencyImpl: HistoryFormDependency {
    
    @Binding var isShowingErrorView: Bool
    @Binding var error: Error?
    
    func tap(record: Record) {
        print("tap \(record)")
    }
    
    func tapAdd() {
        print("add")
    }
    
    func tapSave(data: ExerciseHistory) {
        Task {
            do {
                let _ = try await HistoryRepository.shared.post(data: data)
            } catch {
                DispatchQueue.main.async {
                    withAnimation {
                        self.error = error
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
        paths.append(.historyForm)
    }
    
    func tapHistory(history: ExerciseHistory) {
        print("tap \(history)")
    }
    
    func scrollBottom() {
        store.history.appendHistories()
    }
}

struct WithdrawalConfirmDependencyImpl: WithdrawalConfirmDependency {
    
    @Binding var error: Error?
    @Binding var isShowingErrorView: Bool
    
    func delete() {
        Task {
            if let error = await Authenticator().withDrawal() {
                DispatchQueue.main.async {
                    withAnimation {
                        self.error = error
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

struct SettingViewDependencyImpl: SettingViewDependency {
    
    @Binding var isShowingProfilePhotoPicker: Bool
    @Binding var isShowingDisplayName: Bool
    @Binding var isPresentedWithDrawalConfirm: Bool
    
    func tapDisplayName() {
        withAnimation {
            isShowingDisplayName.toggle()
        }
    }
    
    func tapProfileImage() {
        withAnimation {
            isShowingProfilePhotoPicker.toggle()
        }
    }
    
    func tapWithdrawal() {
        withAnimation {
            isPresentedWithDrawalConfirm.toggle()
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func signOut() throws {
        try Authenticator().signOut()
    }
    
    init(
        isShowingProfilePhotoPicker: Binding<Bool>,
        isShowingDisplayName: Binding<Bool>,
        isPresentedWithDrawalConfirm: Binding<Bool>
    ) {
        _isShowingProfilePhotoPicker = isShowingProfilePhotoPicker
        _isShowingDisplayName = isShowingDisplayName
        _isPresentedWithDrawalConfirm = isPresentedWithDrawalConfirm
    }
}
