//
//  RapidCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/21/24.
//

import SwiftUI
import Rapid

public final class RapidCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
    
    public func rapidSearchTypeList() {
        path.append(RapidNavigation(name: .rapidSearchTypeList))
    }
}
