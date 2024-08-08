//
//  WeightListView.swift
//  Weight
//
//  Created by Donggyu Shin on 8/7/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct WeightListView: View {
    
    @StateObject var viewModel: WeightListViewModel
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    public var body: some View {
        ScrollView {
            if viewModel.weights.isEmpty {
                HStack {
                    Spacer()
                    Text("There is not recent weight data.\nLet's record your weights changes!")
                    Spacer()
                }
                .padding(.vertical)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.regularMaterial)
                        .frame(width: .infinity)
                }
                .padding(.horizontal)
                .padding(.top, 60)
            } else {
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
            }
            
            Spacer(minLength: 60)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Weight")
        .toolbar {
            Button("Add") {
                URLManager.shared.open(url: "dgmuscle://weight_add")
            }
        }
    }
}

#Preview {
    return NavigationStack {
        WeightListView(weightRepository: WeightRepositoryMock())
    }
    .preferredColorScheme(.dark)
}
