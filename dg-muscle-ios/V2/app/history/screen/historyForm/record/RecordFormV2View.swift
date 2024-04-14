//
//  RecordFormV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct RecordFormV2View: View {
    
    @StateObject var viewModel: RecordFormV2ViewModel
    @State private var isPresentSetForm: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let exercise = viewModel.exercise {
                HStack {
                    Text("You are currently doing \(exercise.name)")
                        .font(.title)
                        .fontWeight(.black)
                    Spacer()
                }
            }
            
            Text("Current sets count is \(viewModel.sets.count)")
                .fontWeight(.bold)
                .italic()
            
            Text("Current workout volume is \(Int(viewModel.currentVolume))")
                .fontWeight(.bold)
                .italic()
            
            List {
                ForEach($viewModel.sets) { set in
                    RecordFormSetItem(set: set)
                }
                .onDelete(perform: viewModel.delete)
            }
            .scrollIndicators(.hidden)
            
            Button {
                isPresentSetForm.toggle()
            } label: {
                HStack {
                    Text("ADD NEW SET")
                    Image(systemName: "dumbbell")
                }
                .fontWeight(.black)
                .foregroundStyle(Color(uiColor: .label))
                .padding()
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPresentSetForm, content: {
            if let lastSet = viewModel.sets.last {
                SetFormV2View(viewModel: .init(unit: lastSet.unit,
                                               reps: lastSet.reps,
                                               weight: lastSet.weight, 
                                               isPresenting: $isPresentSetForm,
                                               completeAction: viewModel.post))
            } else {
                SetFormV2View(viewModel: .init(isPresenting: $isPresentSetForm,
                                               completeAction: viewModel.post))
            }
        })
        
    }
}

#Preview {
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 75, id: "1"),
        .init(unit: .kg, reps: 7, weight: 75, id: "2"),
        .init(unit: .kg, reps: 6, weight: 70, id: "3"),
        .init(unit: .kg, reps: 12, weight: 60, id: "4"),
        .init(unit: .kg, reps: 8, weight: 60, id: "5"),
        .init(unit: .kg, reps: 7, weight: 60, id: "6"),
    ]
    
    let record = Record(id: "1", exerciseId: "squat", sets: sets)
    let viewModel = RecordFormV2ViewModel(record: .constant(record), exerciseRepository: ExerciseRepositoryV2Test())
    
    return RecordFormV2View(viewModel: viewModel).preferredColorScheme(.dark)
}
