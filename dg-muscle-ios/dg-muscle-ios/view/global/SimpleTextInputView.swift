//
//  SimpleTextInputView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI

protocol SimpleTextInputDependency {
    func save(text: String) async throws
}

struct SimpleTextInputView: View {
    
    @State var text: String
    @Binding var isShowing: Bool
    @FocusState var focus: Bool
    let placeholder: String
    let dependency: SimpleTextInputDependency
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color(uiColor: .systemBackground).opacity(0.9))
                .onTapGesture {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
            TextField(placeholder, text: $text)
                .focused($focus)
                .onSubmit {
                    Task {
                        try await dependency.save(text: text)
                    }
                    withAnimation {
                        isShowing.toggle()
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: .systemBackground))
                }
                .padding()
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.async {
                focus = true
            }
        }
    }
}
