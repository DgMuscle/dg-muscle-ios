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
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    public var body: some View {
        ScrollView {
            WeightLineChartView(
                weightRepository: weightRepository,
                weights: viewModel.weights,
                range: viewModel.weightRange
            )
            
            VStack {
                ForEach(viewModel.sections, id: \.self) { section in
                    WeightSectionView(section: section)
                }
            }
            
            Spacer(minLength: 60)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Weight")
    }
}

#Preview {
    return NavigationStack {
        WeightListView(weightRepository: WeightRepositoryMock())
    }
    .preferredColorScheme(.dark)
}
