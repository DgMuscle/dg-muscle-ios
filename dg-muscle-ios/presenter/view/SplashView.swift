//
//  SplashView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black)
            
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
