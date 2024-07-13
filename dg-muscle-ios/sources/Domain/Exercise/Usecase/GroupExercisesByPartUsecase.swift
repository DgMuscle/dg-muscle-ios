//
//  GroupExercisesByPartUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/19/24.
//

import Foundation

public final class GroupExercisesByPartUsecase {
    public init() { }
    public func implement(exercises: [Exercise], onlyShowsFavorite: Bool) -> [Exercise.Part: [Exercise]] {
        var exercises = exercises
        
        if onlyShowsFavorite {
            exercises = exercises
                .filter({ $0.favorite })
        }
        
        var hashMap: [Exercise.Part: Set<Exercise>] = [:]
        
        for exercise in exercises {
            for part in exercise.parts {
                hashMap[part, default: []].insert(exercise)
            }
        }
        
        var result: [Exercise.Part: [Exercise]] = [:]
        
        for (part, exercises) in hashMap {
            result[part, default: []].append(contentsOf: Array(exercises.sorted(by: { $0.name < $1.name }) ))
        }
        
        return result
    }
}
