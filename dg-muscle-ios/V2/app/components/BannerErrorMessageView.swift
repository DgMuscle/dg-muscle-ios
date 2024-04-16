//
//  BannerErrorMessageView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct BannerErrorMessageView: View {
    
    var errorMessage: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
                .foregroundStyle(.red)
            
            Text(errorMessage)
            Spacer()
        }
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
    BannerErrorMessageView(errorMessage: "error message")
}
