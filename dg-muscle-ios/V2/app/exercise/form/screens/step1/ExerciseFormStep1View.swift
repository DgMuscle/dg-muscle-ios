//
//  ExerciseFormStep1View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExerciseFormStep1View: View {
    
    @StateObject var viewModel: ExerciseFormStep1ViewModel
    @Binding var paths: [NavigationPath]
    let exerciseRepository: ExerciseRepositoryV2
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.canProceed {
                Button {
                    // TODO: - Navigate to Step2
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
    }
}

#Preview {
    return ExerciseFormStep1View(viewModel: .init(),
                                 paths: .constant([]),
                                 exerciseRepository: ExerciseRepositoryV2Test())
        .preferredColorScheme(.dark)
}
