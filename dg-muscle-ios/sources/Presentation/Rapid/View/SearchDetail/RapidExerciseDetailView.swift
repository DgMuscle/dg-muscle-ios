//
//  RapidExerciseDetailView.swift
//  Rapid
//
//  Created by 신동규 on 7/26/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher
import Flow

public struct RapidExerciseDetailView: View {
    
    @StateObject var viewModel: RapidExerciseDetailViewModel
    
    public init(
        exercise: Domain.RapidExerciseDomain,
        exerciseRepository: ExerciseRepository
    ) {
        _viewModel = .init(wrappedValue: .init(
            exercise: exercise,
            exerciseRepository: exerciseRepository
        ))
    }
    
    public var body: some View {
        ScrollView {
            KFAnimatedImage(.init(string: viewModel.data.gifUrl))
            VStack(alignment: .leading) {
                Text(viewModel.data.equipment.capitalized)
                    .fontWeight(.black)
                Divider()
                bodyPartsView
                Spacer(minLength: 8)
                secondayMusclesView
                Spacer(minLength: 12)
                Text("Instructions")
                    .font(.title)
                    .padding(.bottom, 8)
                instructionsView
            }
            .padding(.horizontal)
            
            Spacer(minLength: 60)
        }
        .animation(.default, value: viewModel.showsSecondaryMuscles)
        .navigationTitle(viewModel.data.name.capitalized)
        .scrollIndicators(.hidden)
    }
    
    var bodyPartsView: some View {
        HStack {
            Text("Body Part:")
                .foregroundStyle(Color(uiColor: .secondaryLabel))
                .italic()
            Text("\(viewModel.data.bodyPart.rawValue.capitalized)(\(viewModel.data.target.capitalized))")
        }
    }
    
    var secondayMusclesView: some View {
        Section {
            if viewModel.showsSecondaryMuscles {
                HFlow {
                    ForEach(viewModel.data.secondaryMuscles, id: \.self) { secondaryMuscle in
                        Text(secondaryMuscle)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                            )
                    }
                }
            }
        } header: {
            Button {
                viewModel.showsSecondaryMuscles.toggle()
            } label: {
                HStack {
                    Text("secondary muscles".capitalized)
                }
            }
        }
    }
    
    var instructionsView: some View {
        ForEach(Array(zip(viewModel.data.instructions.indices, viewModel.data.instructions)), id: \.0) { (index, instruction) in
            HStack(alignment: .top) {
                Text("\(index + 1). ")
                Text(instruction)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    
    let repository = RapidRepositoryMock()
    
    return NavigationStack {
        RapidExerciseDetailView(
            exercise: repository.get()[0],
            exerciseRepository: ExerciseRepositoryMock()
        )
            .preferredColorScheme(.dark)
    }
}
