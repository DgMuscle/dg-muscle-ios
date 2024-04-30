//
//  SplashView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black)
            Rectangle()
                .fill(
                    LinearGradient(colors: [.black, .white.opacity(0.1)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
            
            Text("DG")
                .foregroundStyle(.white)
                .font(.system(size: 100))
                .fontWeight(.black)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    SplashView()
}
