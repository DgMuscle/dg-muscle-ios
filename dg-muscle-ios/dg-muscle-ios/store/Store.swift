//
//  Store.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

let store = Store()

final class Store {
    let exercise = ExerciseStore.shared
    let history = HistoryStore.shared
    let user = UserStore.shared
    
    fileprivate init() { }
}
