//
//  RapidSearchByBodyPartView.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import SwiftUI
import Domain
import MockData

public struct RapidSearchByBodyPartView: View {
    
    @StateObject var viewModel: RapidSearchByBodyPartViewModel
    
    public init(rapidRepository: RapidRepository) {
        _viewModel = .init(wrappedValue: .init(rapidRepository: rapidRepository))
    }
    
    public var body: some View {
        Text("RapidSearchByBodyPartView")
    }
}

#Preview {
    RapidSearchByBodyPartView(rapidRepository: RapidRepositoryMock())
        .preferredColorScheme(.dark)
}
