//
//  SplashView.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var animate: Bool = false
    @State var opacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.background)
                .ignoresSafeArea()
            
            HStack(alignment: .bottom) {
                
                if animate {
                    VStack(alignment: .trailing) {
                        Text("Easy, fast")
                        Text("easy to record")
                    }
                    .opacity(opacity)
                }
                
                Text("DG")
                    .fontWeight(.black)
                    .font(animate ? .callout : .title)
            }
            .animation(.default, value: animate)
            .animation(.easeIn, value: opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    animate.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        opacity = 1
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
