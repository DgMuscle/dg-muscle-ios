//
//  ManageMemoView.swift
//  History
//
//  Created by 신동규 on 6/30/24.
//

import SwiftUI

public struct ManageMemoView: View {
    
    @StateObject var viewModel: ManageMemoViewModel
    @FocusState var focus
    
    public init(memo: Binding<String>) {
        _viewModel = .init(wrappedValue: .init(memo: memo))
    }
    
    public var body: some View {
        TextEditor(text: $viewModel.stateMemo)
            .focused($focus)
            .overlay {
                if viewModel.stateMemo.isEmpty {
                    VStack {
                        HStack {
                            Text("Write memo")
                                .italic()
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .offset(x: 8, y: 8)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
    }
}

#Preview {
    return ManageMemoView(memo: .constant(""))
        .preferredColorScheme(.dark)
}
