//
//  BannerLoadingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct BannerLoadingView: View {
    
    @Binding var loading: Bool
    
    var body: some View {
        HStack {
            ProgressView()
            Text("One moment, please.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.leading)
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
    BannerLoadingView(loading: .constant(true))
        .preferredColorScheme(.dark)
}
