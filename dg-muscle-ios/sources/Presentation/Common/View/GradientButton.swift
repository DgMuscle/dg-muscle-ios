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
    let backgroundColor: Color
    
    public init(
        action: (() -> ())?, 
        text: String,
        backgroundColor: Color = .blue
    ) {
        self.action = action
        self.text = text
        self.backgroundColor = backgroundColor
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
                            colors: [backgroundColor, backgroundColor.opacity(0.4)],
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
