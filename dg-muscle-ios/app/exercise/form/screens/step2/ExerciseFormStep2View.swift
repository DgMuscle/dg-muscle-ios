//
//  ExerciseFormStep2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExerciseFormStep2View: View {
    
    @StateObject var viewModel: ExerciseFormStep2ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            ExerciseSimpleInfoView(name: viewModel.name,
                                   parts: viewModel.parts,
                                   favorite: $viewModel.favorite)
            .padding(.bottom, 40)
            
            HStack {
                Text("Is above information correct?").fontWeight(.black)
                Spacer()
            }
            .padding(.bottom)
            
            Button {
                viewModel.tapRegister()
            } label: {
                Text("YES").fontWeight(.black).foregroundStyle(Color(uiColor: .label))
            }
            .disabled(viewModel.loading)
            
            Spacer()
        }
        .padding()
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.loading)
    }
}

#Preview {
    
    let viewModel = ExerciseFormStep2ViewModel(name: "squat", parts: [.leg, .core], exerciseRepository: ExerciseRepositoryV2Test(), completeAction: nil)
    
    return ExerciseFormStep2View(viewModel: viewModel).preferredColorScheme(.dark)
}
