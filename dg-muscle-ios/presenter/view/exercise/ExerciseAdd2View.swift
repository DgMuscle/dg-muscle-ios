//
//  ExerciseAdd2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseAdd2View: View {
    
    @StateObject var viewModel: ExerciseAdd2ViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.name).fontWeight(.black).font(.title)
                Button {
                    viewModel.favorite.toggle()
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(viewModel.favorite ? .yellow : .secondary)
                }
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Target parts are").foregroundStyle(.secondary)
                Text(viewModel.parts.map({ $0.rawValue }).joined(separator: ", "))
                    .fontWeight(.heavy).italic()
            }
            .padding(.bottom)
            
            HStack {
                Text("Is above information correct?").fontWeight(.black)
                Spacer()
            }
            .padding(.bottom)
            
            Button {
                viewModel.save()
                coordinator.pop()
            } label: {
                Text("YES").fontWeight(.black).foregroundStyle(Color(uiColor: .label))
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let viewModel: ExerciseAdd2ViewModel = .init(name: "Squat",
                                                 parts: [.leg, .core],
                                                 postExerciseUsecase: .init(exerciseRepository: exerciseRepository))
    
    return ExerciseAdd2View(viewModel: viewModel)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
        .preferredColorScheme(.dark)
}
