//
//  ManageMemoView.swift
//  History
//
//  Created by 신동규 on 6/30/24.
//

import SwiftUI

public struct ManageMemoView: View {
    
    @Binding var memo: String
    
    public init(memo: Binding<String>) {
        self._memo = memo
    }
    
    public var body: some View {
        TextEditor(text: $memo)
    }
}

#Preview {
    return ManageMemoView(memo: .constant("Memo\nasd\nasjdhakjsdhaksjhd\n"))
        .preferredColorScheme(.dark)
}
