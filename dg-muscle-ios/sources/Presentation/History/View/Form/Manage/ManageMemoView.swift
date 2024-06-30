//
//  ManageMemoView.swift
//  History
//
//  Created by 신동규 on 6/30/24.
//

import SwiftUI

public struct ManageMemoView: View {
    
    @StateObject var viewModel: ManageMemoViewModel
    
    public init(memo: Binding<String>) {
        _viewModel = .init(wrappedValue: .init(memo: memo))
    }
    
    public var body: some View {
        TextEditor(text: $viewModel.stateMemo)
    }
}

#Preview {
    return ManageMemoView(memo: .constant("Memo\nasd\nasjdhakjsdhaksjhd\n"))
        .preferredColorScheme(.dark)
}
