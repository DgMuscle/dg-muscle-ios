//
//  RoundedGradationText.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct RoundedGradationText: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundStyle(.white)
                .fontWeight(.black)
                
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(colors: [.blue, .indigo],
                                     startPoint: .leading,
                                     endPoint: .trailing))
        )
    }
}
