//
//  HealthRepositoryTest2.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HealthRepositoryTest2: HealthRepositoryDomain {
    var historyMetaDatas: [HistoryMetaDataDomain] { _historyMetaDatas }
    var historyMetaDatasPublisher: AnyPublisher<[HistoryMetaDataDomain], Never> { $_historyMetaDatas.eraseToAnyPublisher() }
    @Published private var _historyMetaDatas: [HistoryMetaDataDomain] = []
    
    var bodyMass: BodyMassDomain? {
        .init(unit: .kg, value: 69, startDate: Date())
    }
    
    var heights: [HeightDomain] { _heights }
    var heightsPublisher: AnyPublisher<[HeightDomain], Never> { $_heights.eraseToAnyPublisher() }
    @Published private var _heights: [HeightDomain] = [.init(unit: .centi, value: 171.2, startDate: Date())]
    
    var recentHeight: HeightDomain? { heights.sorted(by: { $0.startDate > $1.startDate }).first }
    
    var sex: SexDomain? {
        .male
    }
    
    var birthDateComponents: DateComponents? {
        var dateComponents = DateComponents()
        dateComponents.year = 1994
        dateComponents.month = 10
        dateComponents.day = 13
        return dateComponents
    }
    
    var bloodType: BloodTypeDomain? {
        .Op
    }
}
