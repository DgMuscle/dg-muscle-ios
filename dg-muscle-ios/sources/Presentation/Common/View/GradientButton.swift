//
//  GradientButton.swift
//  Common
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI

public struct GradientButton: View {
    
    let action: (() -> ())?
    let text: String
    
    public init(
        action: (() -> ())?, 
        text: String
    ) {
        self.action = action
        self.text = text
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                Spacer()
                Text(text)
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                Spacer()
            }
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [.blue, .blue.opacity(0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
        }
    }
}

#Preview {
    GradientButton(action: nil, text: "Any Button")
        .preferredColorScheme(.dark)
}
