//
//  ExerciseFormStep1ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine

final class ExerciseFormStep1ViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var parts: [Exercise.Part] = []
    @Published private(set) var isVisiblePartsForm: Bool = false
    @Published private(set) var canProceed: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    private func bind() {
        $name
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.isVisiblePartsForm = text.isEmpty == false
            }
            .store(in: &cancellables)
        
        $isVisiblePartsForm
            .removeDuplicates()
            .sink { [weak self] visible in
                if visible == false {
                    self?.parts = []
                }
            }
            .store(in: &cancellables)
        
        $name
            .combineLatest($parts)
            .sink { [weak self] name, parts in
                self?.canProceed = name.isEmpty == false && parts.isEmpty == false
            }
            .store(in: &cancellables)
    }
}
