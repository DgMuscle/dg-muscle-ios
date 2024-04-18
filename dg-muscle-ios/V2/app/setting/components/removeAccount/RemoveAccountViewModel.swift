//
//  RemoveAccountViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Foundation
import Combine
import SwiftUI

final class RemoveAccountViewModel: ObservableObject {
    
    @Published var displayName: String = ""
    @Published var localErrorMessage: String?
    
    let userRepository: UserRepositoryV2
    @Binding var loading: Bool
    @Binding var errorMessage: String?
    @Binding var isPresent: Bool
    
    init(userRepository: UserRepositoryV2,
         loading: Binding<Bool>,
         errorMessage: Binding<String?>,
         isPresent: Binding<Bool>) {
        self.userRepository = userRepository
        self._loading = loading
        self._errorMessage = errorMessage
        self._isPresent = isPresent
    }
    
    @MainActor
    func tapRemoveButton() {
        Task {
            
            if userRepository.user?.uid == "taEJh30OpGVsR3FEFN2s67A8FvF3" {
                localErrorMessage = "Admin account can not be removed."
                return
            }
            
            guard loading == false else { return }
            
            guard userRepository.user?.displayName ?? "" == self.displayName else {
                localErrorMessage = "Please enter your display name again."
                return
            }
            
            loading = true
            isPresent.toggle()
            let error = await userRepository.withDrawal()
            self.errorMessage = error?.localizedDescription
            loading = false
        }
    }
}
