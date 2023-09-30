//
//  Record.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

struct Record: Codable, Identifiable, Equatable {
    static func == (lhs: Record, rhs: Record) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { exerciseId }
    let exerciseId: String
    let sets: [ExerciseSet]
}
