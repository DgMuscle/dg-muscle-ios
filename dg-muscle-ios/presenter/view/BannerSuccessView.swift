//
//  BannerSuccessView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import SwiftUI

struct BannerSuccessView: View {
    
    let message: String
    @State private var animation: Bool = false
    
    var body: some View {
        HStack {
            Text(message)
            if animation {
                Image(systemName: "checkmark.gobackward")
                    .foregroundStyle(.green)
                    .transition(.move(edge: .bottom))
            }
            Spacer()
        }
        .onAppear {
            animation.toggle()
        }
        .animation(.default, value: animation)
        .padding(8)
        .background(
        RoundedRectangle(cornerRadius: 4)
            .fill(
                Color(uiColor: .secondarySystemBackground)
            )
        )
    }
}

#Preview {
    BannerSuccessView(message: "Success")
        .preferredColorScheme(.dark)
}
