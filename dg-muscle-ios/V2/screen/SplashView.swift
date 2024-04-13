//
//  SplashView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var animation: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(colors: [.black, Color(uiColor: .secondarySystemBackground)],
                                   startPoint: animation ? .bottomLeading : .topLeading,
                                   endPoint: animation ? .topTrailing : .bottomTrailing)
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
