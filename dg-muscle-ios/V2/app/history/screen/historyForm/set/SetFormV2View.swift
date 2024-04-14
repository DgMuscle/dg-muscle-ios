//
//  SetFormV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct SetFormV2View: View {
    
    @StateObject var viewModel: SetFormV2ViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("Weight", text: $viewModel.weight)
                    .keyboardType(.decimalPad)
                
                Button {
                    viewModel.unit = viewModel.unit == .kg ? .lb : .kg
                } label: {
                    Text(viewModel.unit.rawValue)
                }
            }
            
            Divider()
            HStack {
                TextField("Reps", text: $viewModel.reps)
                    .keyboardType(.numberPad)
                
                Text("Reps")
            }
            
            Divider()
            
            Button("ADD", action: viewModel.add)
                .padding()
        }
        .fontWeight(.black)
        .padding()
    }
}

#Preview {
    let viewModel: SetFormV2ViewModel = .init(completeAction: nil)
    return SetFormV2View(viewModel: viewModel).preferredColorScheme(.dark)
}
