//
//  MemoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/26/23.
//

import SwiftUI

protocol MemoViewDependency {
    func save(memo: String)
}

struct MemoView: View {
    
    let dependency: MemoViewDependency
    
    @State var memo: String
    @State var edit = false
    
    var body: some View {
        GeometryReader { proxy in
            let minHeight = proxy.size.height / 3
            Form {
                if edit {
                    TextEditor(text: $memo).frame(minHeight: minHeight)
                } else {
                    Text(memo).frame(minHeight: minHeight)
                }
                
                Section {
                    Button("save") {
                        dependency.save(memo: memo)
                    }
                }
            }
            .toolbar {
                Button("Edit") {
                    withAnimation {
                        edit.toggle()
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    struct DP: MemoViewDependency {
        func save(memo: String) { }
    }
    
    return MemoView(dependency: DP(), memo: "pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. pretty long memo. ").preferredColorScheme(.dark)
}

