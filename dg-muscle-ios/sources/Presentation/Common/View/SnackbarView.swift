//
//  SnackbarView.swift
//  Common
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI

public struct SnackbarView: View {
    
    @Binding var message: String?
    
    @State private var offset: CGFloat = 200
    
    public init(message: Binding<String?>) {
        _message = message
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(message ?? "")
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.black.opacity(0.7))
            }
            .padding(.horizontal)
        }
        .foregroundStyle(.white)
        .offset(y: offset)
        .onAppear {
            withAnimation {
                offset = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                dismiss()
            }
        }
    }
    
    private func dismiss() {
        withAnimation {
            offset = 200
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            message = nil 
        }
    }
}
