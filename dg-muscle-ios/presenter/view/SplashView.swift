//
//  SplashView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var animation: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black)
            Rectangle()
                .fill(
                    LinearGradient(colors: [.black, .white.opacity(0.1)],
                                   startPoint: animation ? .bottomLeading : .topLeading,
                                   endPoint: animation ? .topTrailing : .bottomTrailing
                                  )
                )
                .onAppear {
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                        animation = true
                    }
                }
            
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
