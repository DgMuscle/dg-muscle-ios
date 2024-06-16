//
//  RunBar.swift
//  History
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI

struct RunBar: View {
    
    let color: Color
    let percentage: Double
    let startTime: String
    let endTime: String
    let distance: String
    
    @State private var animate: Bool = false
    
    var body: some View {
        HStack(spacing: 40) {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        ZStack {
                            Text(startTime)
                            Text(endTime)
                                .offset(x: geometry.size.width * min(percentage, 0.85))
                        }
                        
                        Spacer()
                    }
                    ZStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                                .frame(width: geometry.size.width)
                            
                            Spacer()
                        }
                        
                            
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(
                                        colors: [color.opacity(0.2), color.opacity(0.8)],
                                        startPoint: animate ? .topLeading : .bottomLeading,
                                        endPoint: animate ? .bottomTrailing : .topTrailing
                                    )
                                )
                                .frame(width: geometry.size.width * percentage)
                            
                            Spacer()
                        }
                    }
                    .frame(height: 30)
                    
                    HStack {
                        Text(distance)
                            .offset(x: geometry.size.width * min(percentage, 0.85))
                        Spacer()
                    }
                }
            }
            .frame(height: 90)
            Image(systemName: "figure.run")
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    RunBar(
        color: .purple,
        percentage: 1,
        startTime: "19:03",
        endTime: "19:41",
        distance: "3.46 km"
    )
    .preferredColorScheme(.dark)
}
