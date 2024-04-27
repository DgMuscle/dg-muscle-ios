//
//  FirstExerciseButton.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct FirstExerciseButton: View {
    
    @State private var animation: Bool = false
    
    let addAction: (() -> ())?
    
    var body: some View {
        Button {
            addAction?()
        } label: {
            Text("Configure Your\nFirst Exercise!")
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(colors: [.blue, .mint],
                                           startPoint: animation ? .bottomLeading : .topLeading,
                                           endPoint: animation ? .topTrailing : .bottomTrailing)
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                                animation = true
                            }
                        }
                )
        }
    }
}

#Preview {
    FirstExerciseButton(addAction: nil).preferredColorScheme(.dark)
}
