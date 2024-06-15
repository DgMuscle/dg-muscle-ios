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
    
    var body: some View {
        HStack(spacing: 12) {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text(startTime)
                        Spacer()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                            
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(
                                        colors: [color.opacity(0.4), color.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * percentage)
                            
                            Spacer()
                        }
                    }
                    .frame(height: 30)
                    
                    HStack {
                        Text(endTime)
                            .offset(x: geometry.size.width * percentage)
                        Spacer()
                    }
                }
            }
            .frame(height: 90)
            Image(systemName: "figure.run")
        }
    }
}

#Preview {
    RunBar(
        color: .purple,
        percentage: 0.7,
        startTime: "7:03",
        endTime: "7:47"
    )
    .preferredColorScheme(.dark)
}
