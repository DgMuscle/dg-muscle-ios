//
//  LoadingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/12/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                    .opacity(0.8)
            }
    }
}
