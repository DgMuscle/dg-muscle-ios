//
//  SuccessView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/12/23.
//

import SwiftUI

struct SuccessView: View {
    
    @Binding var isShowing: Bool
    let message: String?
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
                .font(.largeTitle)
            
            if let message {
                Text(message)
                    .font(.footnote)
                    .italic()
            }
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
