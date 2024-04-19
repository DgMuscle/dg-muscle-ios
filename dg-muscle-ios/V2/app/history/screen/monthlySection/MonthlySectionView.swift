//
//  MonthlySectionView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import SwiftUI

struct MonthlySectionView: View {
    
    @StateObject var viewModel: MonthlySectionViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HorizontalVolumeBarChartView(datas: viewModel.datas,
                                             maxExerciseVolume: viewModel.maxPartVolume)
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    if let mostExercise = viewModel.mostExercise {
                        Text("The most common exercise").bold()
                        HStack {
                            Text(mostExercise.name).fontWeight(.black)
                            Text("(\(Int(viewModel.maxExerciseVolume)))")
                        }
                        .padding(.bottom)
                        
                    }
                    
                    if let leastExercise = viewModel.leastExercise {
                        Text("The least common exercise").bold()
                        HStack {
                            Text(leastExercise.name).fontWeight(.black)
                            Text("(\(Int(viewModel.minExerciseVolume)))")
                        }
                        .padding(.bottom)
                    }
                    
                    if let mostPart = viewModel.mostPart {
                        Text("The most common part").bold()
                        HStack {
                            Text(mostPart.rawValue).fontWeight(.black)
                            Text("(\(Int(viewModel.maxPartVolume)))")
                        }
                        .padding(.bottom)
                    }
                    
                    if let leastPart = viewModel.leastPart {
                        Text("The least common part").bold()
                        HStack {
                            Text(leastPart.rawValue).fontWeight(.black)
                            Text("(\(Int(viewModel.minPartVolume)))")
                        }
                        .padding(.bottom)
                    }
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    
    let histories: [ExerciseHistorySection.History] =
    HistoryRepositoryV2Test().histories.map({ .init(exercise: $0, metadata: nil) })
    let sectionData = ExerciseHistorySection(histories: histories)
    
    let viewModel = MonthlySectionViewModel(exerciseHistorySection: sectionData,
                                            exerciseRepository: ExerciseRepositoryV2Test())
    
    return MonthlySectionView(viewModel: viewModel).preferredColorScheme(.dark)
}
