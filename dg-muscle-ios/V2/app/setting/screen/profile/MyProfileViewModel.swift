//
//  MyProfileViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import Foundation
import Combine
import HealthKit

final class MyProfileViewModel: ObservableObject {
    @Published var user: DGUser?
    @Published var bodyMass: BodyMass?
    @Published var height: Height?
    @Published var sex: HKBiologicalSexObject?
    @Published var birthDateComponents: DateComponents?
    @Published var bloodType: HKBloodTypeObject?
    
    let userRepository: UserRepositoryV2
    let healthRepository: HealthRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2,
         healthRepository: HealthRepository) {
        self.userRepository = userRepository
        self.healthRepository = healthRepository
        
        bodyMass = healthRepository.recentBodyMass
        height = healthRepository.recentHeight
        sex = healthRepository.sex
        birthDateComponents = healthRepository.birthDateComponents
        bloodType = healthRepository.bloodType
        
        bind()
    }
    
    private func bind() {
        userRepository.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
