//
//  Navigations.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import SwiftUI

struct MainNavigation: Identifiable, Hashable {
    
    enum Name: String {
        case setting
        case profile
        case editProfilePhoto
    }
    
    let name: Name
    var id: Int { name.hashValue }
}

struct HistoryNavigation: Identifiable, Hashable {
    
    struct RecordFornIngredient {
        var recordForForm: Binding<Record>
        var dateForRecordForm: Date
        var duration: Binding<String>
    }
    
    static func == (lhs: HistoryNavigation, rhs: HistoryNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
    
    enum Name: String {
        case historyForm
        case recordForm
    }
    
    let name: Name
    var id: Int { name.hashValue }
    var historyForForm: ExerciseHistory?
    var recordFornIngredient: RecordFornIngredient?
}

struct ExerciseNavigation: Identifiable, Hashable, Equatable {
    static func == (lhs: ExerciseNavigation, rhs: ExerciseNavigation) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
    
    enum Name: String {
        case manage
        case edit
        case step1
        case step2
    }
    
    let name: Name
    var id: Int { name.hashValue }
    var step2Depndency: Step2Dependency?
    var editExercise: Exercise?
    
    struct Step2Dependency {
        let name: String
        let parts: [Exercise.Part]
    }
}
