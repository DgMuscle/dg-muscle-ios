//
//  ExerciseFormStep2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine

final class ExerciseFormStep2ViewModel: ObservableObject {
    let name: String
    let parts: [Exercise.Part]
    
    @Published var favorite: Bool = false
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    
    let exerciseRepository: ExerciseRepositoryV2
    let coordinator: Coordinator
    
    init(name: String, 
         parts: [Exercise.Part],
         exerciseRepository: ExerciseRepositoryV2,
         coordinator: Coordinator) {
        self.name = name
        self.parts = parts
        self.exerciseRepository = exerciseRepository
        self.coordinator = coordinator
    }
    
    @MainActor
    func tapRegister() {
        Task {
            guard loading == false else { return }
            loading = true
            do {
                try await registerExercise()
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
        coordinator.path.removeLast(2)
    }
    
    private func registerExercise() async throws {
        let data = Exercise(id: UUID().uuidString, name: name, parts: parts, favorite: favorite, order: 0, createdAt: nil)
        let _ = try await exerciseRepository.post(data: data)
        
    }
}
