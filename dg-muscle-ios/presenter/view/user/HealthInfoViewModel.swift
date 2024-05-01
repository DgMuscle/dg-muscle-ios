//
//  HealthInfoViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HealthInfoViewModel: ObservableObject {
    @Published var items: [HealthItemV] = []
    
    private var weight: HealthItemV = .init(left: "Weight",
                                               right: "-",
                                               image: HealthInfoV.SystemImage.weight.rawValue,
                                               color: HealthInfoV.color(of: .weight))
    
    private var height: HealthItemV = .init(left: "Height",
                                               right: "-",
                                               image: HealthInfoV.SystemImage.height.rawValue,
                                               color: HealthInfoV.color(of: .height))
    
    private var sex: HealthItemV = .init(left: "Sex",
                                               right: "-",
                                               image: HealthInfoV.SystemImage.sex.rawValue,
                                               color: HealthInfoV.color(of: .sex))
    
    private var birth: HealthItemV = .init(left: "Birthday",
                                               right: "-",
                                               image: HealthInfoV.SystemImage.birth.rawValue,
                                               color: HealthInfoV.color(of: .birth))
    
    private var blood: HealthItemV = .init(left: "Blood Type",
                                               right: "-",
                                               image: HealthInfoV.SystemImage.blood.rawValue,
                                               color: HealthInfoV.color(of: .bloodType))
    
    
    
    private let info: HealthInfoV
    private let getHealthInfoUsecase: GetHealthInfoUsecase
    
    init(getHealthInfoUsecase: GetHealthInfoUsecase) {
        self.getHealthInfoUsecase = getHealthInfoUsecase
        let (bm, dc, bt, h, s) = getHealthInfoUsecase.implement()
        info = .init(bodyMass: bm, dateComponents: dc, bloodType: bt, height: h, sex: s)
        
        configure()
    }
    
    private func configure() {
        
        if let weight = info.weight {
            self.weight.left = "Weight(\(weight.unit.rawValue))"
            self.weight.right = String(weight.value)
        }
        
        if let height = info.height {
            self.height.right = String(height)
        }
        
        if let sex = info.sex {
            self.sex.right = sex.rawValue
        }
        
        if let birthDate = info.birthdate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            self.birth.right = dateFormatter.string(from: birthDate)
        }
        
        if let bloodType = info.bloodType {
            self.blood.right = bloodType.rawValue
        }
        
        items = [
        weight, height, sex, birth, blood
        ]
    }
}
