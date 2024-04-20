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
    
    @Published private var sex: HKBiologicalSexObject?
    @Published private var birthDateComponents: DateComponents?
    @Published private var bloodType: HKBloodTypeObject?
    
    @Published var sexString: String = ""
    @Published var birthDateString: String = ""
    @Published var bloodTypeString: String = ""
    
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
        
        $sex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sex in
                guard let sex else {
                    self?.sexString = "Need Input"
                    return
                }
                
                switch sex.biologicalSex {
                case .female:  self?.sexString = "Female"
                case .male: self?.sexString = "Male"
                case .notSet: self?.sexString = "Not Set"
                case .other: self?.sexString = "Other"
                @unknown default: self?.sexString = "Unknown"
                }
            }
            .store(in: &cancellables)
        
        $birthDateComponents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] components in
                
                guard let year = components?.year, let month = components?.month, let day = components?.day else {
                    self?.birthDateString = "Need Input"
                    return
                }
                
                self?.birthDateString = "\(year).\(month).\(day)"
            }
            .store(in: &cancellables)
        
        $bloodType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bloodType in
                guard let bloodType else {
                    self?.bloodTypeString = "Need Input"
                    return
                }
                
                switch bloodType.bloodType {
                    
                case .notSet:
                    self?.bloodTypeString = "Not Set"
                case .aPositive:
                    self?.bloodTypeString = "A+"
                case .aNegative:
                    self?.bloodTypeString = "A-"
                case .bPositive:
                    self?.bloodTypeString = "B+"
                case .bNegative:
                    self?.bloodTypeString = "B-"
                case .abPositive:
                    self?.bloodTypeString = "AB+"
                case .abNegative:
                    self?.bloodTypeString = "AB-"
                case .oPositive:
                    self?.bloodTypeString = "O+"
                case .oNegative:
                    self?.bloodTypeString = "O-"
                @unknown default:
                    self?.bloodTypeString = "Unknown"
                }
            }
            .store(in: &cancellables)
    }
}
