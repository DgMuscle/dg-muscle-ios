//
//  ManageExerciseViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine

final class ManageExerciseViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isVisibleAddButton: Bool = false
    
    let exerciseRepository: ExerciseRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(exerciseRepository: ExerciseRepositoryV2) {
        self.exerciseRepository = exerciseRepository
        bind()
    }
    
    @MainActor
    func delete(data: Exercise) {
        Task {
            guard loading == false else { return }
            loading = true
            do {
                let _ = try await exerciseRepository.delete(data: data)
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
    }
    
    private func bind() {
        exerciseRepository.exercisesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exercises in
                self?.isVisibleAddButton = exercises.isEmpty == false
            }
            .store(in: &cancellables)
    }
}
