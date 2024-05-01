//
//  HealthInfoV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

struct HealthInfoV {
    var weight: Weight? = nil
    var height: Double? = nil
    var sex: SexV? = nil
    var birthdate: Date? = nil
    var bloodType: BloodTypeV? = nil
    
    init(bodyMass: BodyMassDomain?,
         dateComponents: DateComponents?,
         bloodType: BloodTypeDomain?,
         height: HeightDomain?,
         sex: SexDomain?
    ) {
        if let bodyMass {
            var unit: Weight.Unit
            
            switch bodyMass.unit {
            case .kg:
                unit = .kg
            case .lbs:
                unit = .lbs
            }
            
            weight = .init(unit: unit, value: bodyMass.value)
        }
        
        if let dateComponents {
            birthdate = Calendar.current.date(from: dateComponents)
        }
        
        if let bloodType {
            switch bloodType {
            case .Ap:
                self.bloodType = .Ap
            case .An:
                self.bloodType = .An
            case .Bp:
                self.bloodType = .Bp
            case .Bn:
                self.bloodType = .Bn
            case .Op:
                self.bloodType = .Op
            case .On:
                self.bloodType = .On
            case .ABp:
                self.bloodType = .ABp
            case .ABn:
                self.bloodType = .ABn
            }
        }
        
        if let height {
            self.height = height.value
        }
        
        if let sex {
            switch sex {
            case .male:
                self.sex = .male
            case .female:
                self.sex = .female
            case .other:
                break
            }
        }
    }
    
    static func color(of: InfoType) -> Color {
        switch of {
        case .weight:
            return .green
        case .height:
            return .blue
        case .sex:
            return .cyan
        case .birth:
            return .purple
        case .bloodType:
            return .red
        }
    }
    
}

extension HealthInfoV {
    struct Weight {
        enum Unit: String {
            case kg
            case lbs
        }
        var unit: Unit
        var value: Double
    }
    
    enum SystemImage: String {
        case weight = "figure"
        case height = "figure.walk"
        case sex = "figure.dress.line.vertical.figure"
        case birth = "birthday.cake"
        case blood = "drop"
    }
    
    enum InfoType {
        case weight
        case height
        case sex
        case birth
        case bloodType
    }
}
