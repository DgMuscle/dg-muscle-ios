//
//  WeightAddView.swift
//  Weight
//
//  Created by Donggyu Shin on 8/8/24.
//

import SwiftUI
import Domain
import MockData

public struct WeightAddView: View {
    
    @StateObject var viewModel: WeightAddViewModel
    
    public init(weightRepository: WeightRepository) {
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    public var body: some View {
        Text("WeightAddView")
    }
}
