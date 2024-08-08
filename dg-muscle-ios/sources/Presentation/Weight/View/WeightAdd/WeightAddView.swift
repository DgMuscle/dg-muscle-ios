//
//  WeightAddView.swift
//  Weight
//
//  Created by Donggyu Shin on 8/8/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct WeightAddView: View {
    
    @StateObject var viewModel: WeightAddViewModel
    
    public init(weightRepository: WeightRepository) {
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    public var body: some View {
        List {
            Section("Date") {
                DatePicker("Date", selection: $viewModel.selectedDate)
            }
            
            Section("Weight(kg)") {
                TextField("Weight(kg)", value: $viewModel.value, format: .number)
                    .keyboardType(.decimalPad)
            }
        }
        .scrollIndicators(.hidden)
        .toolbar {
            Button("save") {
                viewModel.save()
            }
        }
        .overlay {
            ZStack {
                if viewModel.errorMessage != nil {
                    Common.SnackbarView(message: $viewModel.errorMessage)
                }
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
