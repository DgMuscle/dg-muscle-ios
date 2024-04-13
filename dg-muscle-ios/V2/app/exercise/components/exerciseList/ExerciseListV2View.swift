//
//  ExerciseListV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListV2View: View {
    @StateObject var viewModel: ExerciseListV2ViewModel
    @State private var isAnimating: Bool = false
    
    let exerciseAction: ((Exercise) -> ())?
    let addAction: (() -> ())?
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.sections, id: \.self) { section in
                    ExerciseListSectionV2View(part: section.part, exercises: section.exercises, exerciseAction: exerciseAction)
                        .padding(.bottom, 8)
                }
            }
            
            if viewModel.sections.isEmpty {
                Button {
                    addAction?()
                } label: {
                    Text("Configure Your\nFirst Exercise!")
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(colors: [.blue, .pink],
                                                   startPoint: isAnimating ? .bottomLeading : .topLeading,
                                                   endPoint: isAnimating ? .topTrailing : .bottomTrailing)
                                )
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                                isAnimating.toggle()
                            }
                        }
                }
            }
        }
        .drawingGroup()
    }
}

#Preview {
    
    let viewModel: ExerciseListV2ViewModel = .init(exerciseRepository: ExerciseRepositoryV2Test())
    
    return ExerciseListV2View(viewModel: viewModel,
                              exerciseAction: nil,
                              addAction: nil)
        .preferredColorScheme(.dark)
}
