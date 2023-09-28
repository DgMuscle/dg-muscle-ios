//
//  SimpleTextInputView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI

protocol SimpleTextInputDependency {
    func save(text: String)
}

struct SimpleTextInputView: View {
    
    @State var text: String
    @Binding var isShowing: Bool
    let displayName: String
    let dependency: SimpleTextInputDependency
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color(uiColor: .systemBackground).opacity(0.9))
                .onTapGesture {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
            TextField(displayName, text: $text)
                .onSubmit {
                    dependency.save(text: text)
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
    }
}

