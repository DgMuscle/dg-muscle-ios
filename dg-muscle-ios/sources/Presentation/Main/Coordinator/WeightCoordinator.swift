//
//  WeightCoordinator.swift
//  Weight
//
//  Created by Donggyu Shin on 8/7/24.
//

import Foundation
import SwiftUI

public final class WeightCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    public func weightList() {
        path.append(WeightNavigation(name: .weightList))
    }
}
