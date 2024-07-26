//
//  RapidSearchByNameView.swift
//  App
//
//  Created by Donggyu Shin on 7/23/24.
//

import SwiftUI
import Domain
import MockData

public struct RapidSearchByNameView: View {
    
    @StateObject var viewModel: RapidSearchByNameViewModel
    
    public init(rapidRepository: RapidRepository) {
        _viewModel = .init(wrappedValue: .init(rapidRepository: rapidRepository))
    }
    
    public var body: some View {
        ScrollView {
            
        }
        .scrollIndicators(.hidden)
        .searchable(text: $viewModel.query)
    }
}

#Preview {
    return NavigationStack {
        RapidSearchByNameView(rapidRepository: RapidRepositoryMock())
    }
    .preferredColorScheme(.dark)
}
