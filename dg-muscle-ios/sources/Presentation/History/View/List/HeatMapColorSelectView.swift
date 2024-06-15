//
//  HeatMapColorSelectView.swift
//  History
//
//  Created by 신동규 on 5/20/24.
//

import SwiftUI
import Domain
import MockData

public struct HeatMapColorSelectView: View {
    
    @StateObject var viewModel: HeatMapColorSelectViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 50, maximum: 100))
    ]
    
    public init (userRepository: UserRepository) {
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        ZStack {
            
            Rectangle()
                .fill(
                    viewModel.selectedColor.color.opacity(0.4)
                )
                .ignoresSafeArea()
            
            VStack {
                LazyVGrid(columns: columns, spacing: 10, content: {
                    ForEach(viewModel.colors, id: \.self) { color in
                        Button {
                            viewModel.select(color)
                        } label: {
                            RoundedRectangle(cornerRadius: 8).fill(color.color)
                                .frame(height: 50)
                        }
                    }
                })
                Spacer()
            }
            .padding(.horizontal)
        }
        .animation(.default, value: viewModel.selectedColor)
    }
}

#Preview {
    return HeatMapColorSelectView(userRepository: UserRepositoryMock())
        .preferredColorScheme(.dark)
}
