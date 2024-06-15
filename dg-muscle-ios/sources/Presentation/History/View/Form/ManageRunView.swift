//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import MockData
import Domain

public struct ManageRunView: View {
    
    @StateObject var viewModel: ManageRunViewModel
    
    public init(run: Binding<Run>) {
        _viewModel = .init(wrappedValue: .init(run: run))
    }
    
    public var body: some View {
        Text("ManageRunView")
    }
}

#Preview {
    ManageRunView(run: .constant(.init(domain: HISTORY_1.run!)))
        .preferredColorScheme(.dark)
}
