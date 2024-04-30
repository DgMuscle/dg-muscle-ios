//
//  GetVolumesGroupedByPartUsecaseTests.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/30/24.
//

import XCTest

final class GetVolumesGroupedByPartUsecaseTests: XCTestCase {

    func test() throws {
        let usecase = GetVolumesGroupedByPartUsecase(exerciseRepository: ExerciseRepositoryTest())
        
        let sets1: [ExerciseSetDomain] = [
            .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60),
            .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 30),
            .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
            .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 70),
        ]
        
        let sets2: [ExerciseSetDomain] = [
            .init(id: UUID().uuidString, unit: .kg, reps: 8, weight: 60),
            .init(id: UUID().uuidString, unit: .kg, reps: 7, weight: 30),
            .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
            .init(id: UUID().uuidString, unit: .kg, reps: 10, weight: 70),
        ]
        
        let records: [RecordDomain] = [
            .init(id: UUID().uuidString, exerciseId: "squat", sets: sets1),
            .init(id: UUID().uuidString, exerciseId: "bench press", sets: sets2)
        ]
        let history: HistoryDomain = .init(id: "", date: Date(), memo: nil, records: records)
        let result = usecase.implement(history: history)
        
        XCTAssertEqual(result[.leg], 2400)
    }
}
