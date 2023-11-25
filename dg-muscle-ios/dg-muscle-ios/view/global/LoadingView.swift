//
//  LoadingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/12/23.
//

import SwiftUI

struct LoadingView: View {
    
    let message: String?
    
    var body: some View {
        
        VStack(spacing: 12) {
            ProgressView()
            if let message {
                Text(message)
                    .font(.footnote)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .opacity(0.8)
        }
    }
}

#Preview {
    ZStack {
        Rectangle()
        LoadingView(message: "please don't quit the app")
    }
    .preferredColorScheme(.dark)
}
