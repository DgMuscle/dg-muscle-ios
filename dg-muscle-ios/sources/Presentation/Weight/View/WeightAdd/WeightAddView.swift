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
        List {
            DatePicker("Date", selection: $viewModel.selectedDate)
            
            TextField("Weight(kg)", value: $viewModel.value, format: .number)
                .keyboardType(.decimalPad)
        }
        .scrollIndicators(.hidden)
        .toolbar {
            Button("save") {
                viewModel.save()
            }
        }
    }
}

#Preview {
    return NavigationStack {
        WeightAddView(weightRepository: WeightRepositoryMock())
    }
    .preferredColorScheme(.dark)
}
