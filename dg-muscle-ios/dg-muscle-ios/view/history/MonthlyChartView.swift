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
    @State var markTypeToggle = false
    
    private let allExercises: [Exercise]
    
    init(histories: [ExerciseHistory], volumeByPart: [String: Double]) {
        self.histories = histories
        self.volumeByPart = volumeByPart
        let allRecords = histories.flatMap({ $0.records })
        var allExerciseIds: Set<String> = []
        
        allRecords.forEach({ allExerciseIds.insert($0.exerciseId) })
        
        self.allExercises = Array(allExerciseIds).compactMap({ id in
            store.exercise.exercises.first(where: { $0.id == id })
        }).sorted(by: { $0.name < $1.name })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Toggle(isOn: $markTypeToggle) {
                    Text("Line").italic()
                }
                ForEach(allExercises, id: \.self) { exercise in
                    
                    HStack {
                        Text(exercise.name).font(.title2.bold())
                        Spacer()
                    }
                    
                    ChartView(
                        datas: ChartView.generateDataBasedOnExercise(from: histories, exerciseId: exercise.id, length: 7),
                        markType: $markType
                    )
                        .frame(height: 250)
                    
                    Spacer(minLength: 50)
                }
                Spacer(minLength: 50)
                PieChartView(datas: volumeByPart.map({ .init(name: $0.key, value: $0.value) }))
                    .frame(height: 250)
                
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .onChange(of: markTypeToggle) { oldValue, newValue in
            self.markType = newValue ? .line : .bar
        }
    }
}

