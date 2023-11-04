//
//  MonthlyChartView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/22/23.
//

import SwiftUI

struct MonthlyChartView: View {
    
    let histories: [ExerciseHistory]
    let volumeByPart: [String: Double]
    @State var markType: ChartView.MarkType = .bar
    @Binding var showing: Bool
    
    private let allExercises: [Exercise]
    
    init(histories: [ExerciseHistory], volumeByPart: [String: Double], showing: Binding<Bool>) {
        self.histories = histories
        self.volumeByPart = volumeByPart
        self._showing = showing
        let allRecords = histories.flatMap({ $0.records })
        var allExerciseIds: Set<String> = []
        
        allRecords.forEach({ allExerciseIds.insert($0.exerciseId) })
        
        self.allExercises = Array(allExerciseIds).compactMap({ id in
            store.exercise.exercises.first(where: { $0.id == id })
        }).sorted(by: { $0.order < $1.order })
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("mark type", selection: $markType) {
                    ForEach(ChartView.MarkType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Button {
                    withAnimation {
                        showing = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding(6)
                        .background {
                            Circle().fill(Color.gray.opacity(0.6))
                        }
                }
            }
            .padding()
            
            ScrollView {
                VStack {
                    ForEach(allExercises, id: \.self) { exercise in
                        
                        HStack {
                            Text(exercise.name).font(.title2.bold())
                            Spacer()
                        }
                        
                        ChartView(
                            datas: ChartView.generateDataBasedOnExercise(from: histories, exerciseId: exercise.id, length: 7),
                            markType: $markType,
                            valueName: "volume"
                        )
                        .frame(height: 250)
                        
                        Spacer(minLength: 50)
                    }
                    
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .background {
            Rectangle().fill(Color(uiColor: .systemBackground))
                .ignoresSafeArea()
        }
    }
}
