//
//  RapidSearchByNameView.swift
//  App
//
//  Created by Donggyu Shin on 7/23/24.
//

import SwiftUI
import Domain

public struct RapidSearchByNameView: View {
    
    @StateObject var viewModel: RapidSearchByNameViewModel
    
    public init(rapidRepository: RapidRepository) {
        _viewModel = .init(wrappedValue: .init(rapidRepository: rapidRepository))
    }
    
    public var body: some View {
        Text("rapid search by name")
    }
}
