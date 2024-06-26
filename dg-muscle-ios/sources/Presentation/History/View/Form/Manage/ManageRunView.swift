//
//  ManageRunView.swift
//  History
//
//  Created by 신동규 on 6/26/24.
//

import SwiftUI
import Domain
import MockData

public struct ManageRunView: View {
    
    @StateObject var viewModel: ManageRunViewModel
    
    public init(run: Binding<RunPresentation>) {
        _viewModel = .init(wrappedValue: .init(run: run))
    }
    
    public var body: some View {
        Text("ManageRunView")
    }
}

#Preview {
    let run = HISTORY_1.run!
    let view = ManageRunView(run: .constant(.init(domain: run)))
    return view
        .preferredColorScheme(.dark)
}
