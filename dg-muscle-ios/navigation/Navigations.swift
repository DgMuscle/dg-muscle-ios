//
//  Navigations.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import SwiftUI

struct MainNavigation: Identifiable, Hashable {
    static func == (lhs: MainNavigation, rhs: MainNavigation) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
    
    struct OpenWebIngredient {
        var url: String
    }
    
    enum Name: String {
        case setting
        case profile
        case editProfilePhoto
        case selectHeatmapColor
        case openWeb
    }
    
    let name: Name
    var id: Int { name.hashValue }
    var openWebIngredient: OpenWebIngredient?
}

struct HistoryNavigation: Identifiable, Hashable {
    
    struct RecordFormIngredient {
        var recordForForm: Binding<Record>
        var dateForRecordForm: Date
        var startTimeInterval: TimeInterval
    }
    
    static func == (lhs: HistoryNavigation, rhs: HistoryNavigation) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
    
    enum Name: String {
        case historyForm
        case recordForm
        case monthlySection
    }
    
    let name: Name
    var id: Int { name.hashValue }
    var historyForForm: ExerciseHistory?
    var recordFormIngredient: RecordFormIngredient?
    var monthlySectionIngredient: ExerciseHistorySection?
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
    var editIngredient: Exercise?
    
    struct Step2Dependency {
        let name: String
        let parts: [Exercise.Part]
    }
}
