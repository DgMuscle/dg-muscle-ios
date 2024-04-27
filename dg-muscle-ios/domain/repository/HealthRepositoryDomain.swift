//
//  HealthRepositoryDomain.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

protocol HealthRepositoryDomain {
    var historyMetaDatas: [HistoryMetaDataDomain] { get }
    var historyMetaDatasPublisher: AnyPublisher<[HistoryMetaDataDomain], Never> { get }
    var bodyMass: BodyMassDomain? { get }
    var heights: [HeightDomain] { get }
    var heightsPublisher: AnyPublisher<[HeightDomain], Never> { get }
    var recentHeight: HeightDomain? { get }
    var sex: SexDomain? { get }
    var birthDateComponents: DateComponents? { get }
    var bloodType: BloodTypeDomain? { get }
}
