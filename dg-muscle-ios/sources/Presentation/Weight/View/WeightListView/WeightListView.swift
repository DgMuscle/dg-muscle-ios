//
//  WeightListView.swift
//  Weight
//
//  Created by Donggyu Shin on 8/7/24.
//

import SwiftUI
import Domain
import MockData

public struct WeightListView: View {
    
    @StateObject var viewModel: WeightListViewModel
    
    public init(weightRepository: WeightRepository) {
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    public var body: some View {
        Text("WeightListView")
    }
}

#Preview {
    return WeightListView(weightRepository: WeightRepositoryMock())
        .preferredColorScheme(.dark)
}
