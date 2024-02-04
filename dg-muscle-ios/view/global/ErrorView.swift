//
//  ErrorView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/29.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "xmark.octagon").font(.largeTitle).foregroundStyle(.red)
            Text(message)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12).fill(Color(uiColor: .secondarySystemGroupedBackground)).opacity(0.8)
        }
        .padding()
        .onTapGesture {
            withAnimation {
                isShowing = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
}
