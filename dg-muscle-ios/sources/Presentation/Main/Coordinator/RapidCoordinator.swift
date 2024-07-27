//
//  RapidCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/21/24.
//

import SwiftUI
import Rapid
import Domain

public final class RapidCoordinator {
    @Binding var path: NavigationPath
    
    private let rapidRepository: RapidRepository
    
    init(
        path: Binding<NavigationPath>,
        rapidRepository: RapidRepository
    ) {
        _path = path
        self.rapidRepository = rapidRepository
    }
    
    public func rapidSearchTypeList() {
        path.append(RapidNavigation(name: .rapidSearchTypeList))
    }
    
    public func rapidSearchByBodyPart() {
        path.append(RapidNavigation(name: .rapidSearchByBodyPart))
    }
    
    public func rapidSearchByName() {
        path.append(RapidNavigation(name: .rapidSearchByName))
    }
    
    public func rapidDetail(id: String) {
        let usecase = SearchRapidExerciseByIdUsecase(rapidRepository: rapidRepository)
        if let exercise = usecase.implement(id: id) {
            path.append(RapidNavigation(name: .detail(exercise)))
        }
    }
}
