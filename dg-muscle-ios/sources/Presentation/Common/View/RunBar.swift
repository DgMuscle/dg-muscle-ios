//
//  RunBar.swift
//  Common
//
//  Created by 신동규 on 6/23/24.
//

import SwiftUI

public struct RunBar: View {
    
    public let color: Color
    public let percentage: Double
    public let startTime: String
    public let endTime: String
    public let distance: String
    
    @State private var animate: Bool = false
    
    public init(
        color: Color,
        percentage: Double,
        startTime: String,
        endTime: String,
        distance: String
    ) {
        self.color = color
        self.percentage = percentage
        self.startTime = startTime
        self.endTime = endTime
        self.distance = distance
    }
    
    public var body: some View {
        HStack(spacing: 40) {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        ZStack {
                            Text(startTime)
                            if percentage >= 0.2 {
                                Text(endTime)
                                    .offset(x: geometry.size.width * min(percentage, 0.85))
                            }
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
        percentage: 0.2,
        startTime: "19:03",
        endTime: "19:41",
        distance: "3.46 km"
    )
    .preferredColorScheme(.dark)
}

