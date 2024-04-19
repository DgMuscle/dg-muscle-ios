//
//  HistorySectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct HistorySectionView: View {
    
    var section: ExerciseHistorySection
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    
    let historyAction: ((ExerciseHistory) -> ())?
    let deleteAction: ((ExerciseHistory) -> ())?
    let tapSectionHeader: (() -> ())?
    
    var body: some View {
        VStack {
            Button {
                tapSectionHeader?()
            } label: {
                HStack {
                    Text(section.header)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Spacer()
                }
                .foregroundStyle(LinearGradient(colors: [Color(uiColor: .label),
                                                         Color(uiColor: .label).opacity(0.4)],
                                                startPoint: .leading,
                                                endPoint: .trailing))
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            
            ForEach(section.histories) { history in
                
                Button {
                    historyAction?(history.exercise)
                } label: {
                    HistoryListItemView(history: history, exerciseRepository: exerciseRepository, healthRepository: healthRepository)
                        .padding(.bottom, 20)
                        .scrollTransition { effect, phase in
                            effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                        }
                        .contextMenu {
                            if let deleteAction {
                                Button("DELETE HISTORY") {
                                    deleteAction(history.exercise)
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 75, id: "1"),
        .init(unit: .kg, reps: 10, weight: 75, id: "2"),
        .init(unit: .kg, reps: 10, weight: 75, id: "3"),
        .init(unit: .kg, reps: 10, weight: 75, id: "4"),
        .init(unit: .kg, reps: 10, weight: 75, id: "5"),
    ]
    
    let records: [Record] = [
        .init(id: "1", exerciseId: "squat", sets: sets),
        .init(id: "2", exerciseId: "bench press", sets: sets),
    ]
    
    let exerciseHistory: ExerciseHistory = .init(id: "1", date: "20240404", memo: "memo", records: records, createdAt: nil)
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let startDate = dateFormatter.date(from: "2024-04-04 20:00:00")!
    let endDate = dateFormatter.date(from: "2024-04-04 20:20:00")
    
    let metadata = WorkoutMetaData(duration: 2500, kcalPerHourKg: 82, startDate: startDate, endDate: endDate)
    
    let histories: [ExerciseHistorySection.History] = [
        .init(exercise: exerciseHistory, metadata: metadata),
        .init(exercise: exerciseHistory, metadata: nil),
        .init(exercise: exerciseHistory, metadata: metadata),
    ]
    
    let section: ExerciseHistorySection = .init(histories: histories)
    
    return HistorySectionView(section: section, 
                              exerciseRepository: ExerciseRepositoryV2Test(),
                              healthRepository: HealthRepositoryTest(),
                              historyAction: nil, 
                              deleteAction: nil, 
                              tapSectionHeader: nil)
        .preferredColorScheme(.dark)
}