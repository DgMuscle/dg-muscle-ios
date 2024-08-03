//
//  WhiteUnderlineTextLabel.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import SwiftUI

struct WhiteUnderlineTextLabel: View {
    
    let text: String
    let tap: (() -> ())?
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundStyle(.white)
            Rectangle()
                .fill(.white.opacity(0.6))
                .frame(height: 1)
        }
        .overlay {
            HStack {
                Spacer()
                Image(systemName: "pencil")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    WhiteUnderlineTextLabel(text: "동규", tap: nil)
        .preferredColorScheme(.dark)
}
