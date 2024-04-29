//
//  HistoryFormSetView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import SwiftUI

struct HistoryFormSetView: View {
    @StateObject var viewModel: HistoryFormSetViewModel
    let save: ((ExerciseSetV) -> ())?
    
    var body: some View {
        VStack {
            HStack {
                textField(label: "Weight(kg)", value: $viewModel.weight)
                
                Button("+") {
                    viewModel.updateWeight(type: .up)
                }
                .padding()
                
                Button("-") {
                    viewModel.updateWeight(type: .down)
                }
                .padding()
            }
            
            HStack {
                textField(label: "Reps", value: $viewModel.reps)
                
                Button("+") {
                    viewModel.updateReps(type: .up)
                }
                .padding()
                
                Button("-") {
                    viewModel.updateReps(type: .down)
                }
                .padding()
            }
            
            Button {
                save?(viewModel.set)
            } label: {
                RoundedGradationText(text: "SAVE")
            }
        }
        .padding()
    }
    
    func textField<T>(label: String, value: Binding<T>) -> some View {
        VStack {
            HStack {
                Text(label)
                    .fontWeight(.medium)
                    .font(.caption)
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .blue.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                    )
                Spacer()
            }
            
            TextField(label, value: value, formatter: NumberFormatter())
            Divider()
        }
    }
}

#Preview {

    let viewModel: HistoryFormSetViewModel = .init(set: .init(id: "1", reps: 12, weight: 60))
    
    return HistoryFormSetView(viewModel: viewModel, save: nil)
        .preferredColorScheme(.dark)
}
