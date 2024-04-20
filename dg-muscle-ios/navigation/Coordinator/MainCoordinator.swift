//
//  MainCoordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import SwiftUI

final class MainCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func setting() {
        path.append(MainNavigation(name: .setting))
    }
    
    func profile() {
        path.append(MainNavigation(name: .profile))
    }
    
    func editProfilePhoto() {
        path.append(MainNavigation(name: .editProfilePhoto))
    }
    
    func selectHeatmapColor() {
        path.append(MainNavigation(name: .selectHeatmapColor))
    }
    
    func openWeb(url: String) {
        path.append(MainNavigation(name: .openWeb, openWebIngredient: .init(url: url)))
    }
}
