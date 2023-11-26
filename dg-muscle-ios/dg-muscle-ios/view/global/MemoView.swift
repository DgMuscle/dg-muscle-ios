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
    
    var body: some View {
        GeometryReader { proxy in
            let minHeight = proxy.size.height / 3
            Form {
                TextEditor(text: $memo).frame(minHeight: minHeight)
                
                Section {
                    Button("save") {
                        dependency.save(memo: memo)
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

