//
//  ExerciseFormStep1View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExerciseFormStep1View: View {
    
    typealias GlobalNavigationPath = NavigationPath
    
    @StateObject var viewModel: ExerciseFormStep1ViewModel
    @State private var paths: [LocalNavigationPath] = []
    @Binding var globalPaths: [GlobalNavigationPath]
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        ZStack {
            NavigationStack(path: $paths) {
                VStack(alignment: .leading) {
                    if viewModel.canProceed {
                        Button {
                            paths.append(.step2)
                        } label: {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrowshape.right")
                            }
                            .foregroundStyle(Color(uiColor: .label))
                            .fontWeight(.black)
                            .padding(.bottom, 40)
                        }
                    }
                    
                    if viewModel.isVisiblePartsForm {
                        Text("What's the target parts of this exercise?").font(.headline)
                        ExercisePartsSelectionForm(viewModel: .init(parts: $viewModel.parts))
                            .padding(.bottom, 40)
                    }
                    
                    Text("What's the name of the exercise?").font(.headline)
                    TextField("Squat", text: $viewModel.name)
                    Divider()
                    
                    Spacer()
                }
                .padding()
                .animation(.default, value: viewModel.isVisiblePartsForm)
                .animation(.default, value: viewModel.canProceed)
                .navigationDestination(for: LocalNavigationPath.self) { path in
                    switch path {
                    case .step2:
                        ExerciseFormStep2View(viewModel: .init(name: viewModel.name,
                                                               parts: viewModel.parts,
                                                               exerciseRepository: exerciseRepository,
                                                               completeAction: {
                            let _ = globalPaths.removeLast()
                        }))
                    }
                }
            }
        }
    }
}

extension ExerciseFormStep1View {
    enum LocalNavigationPath: Hashable {
        case step2
    }
}

#Preview {
    return ExerciseFormStep1View(viewModel: .init(),
                                 globalPaths: .constant([]),
                                 exerciseRepository: ExerciseRepositoryV2Test())
        .preferredColorScheme(.dark)
}
