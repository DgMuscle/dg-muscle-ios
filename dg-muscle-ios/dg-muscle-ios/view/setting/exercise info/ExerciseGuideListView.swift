//
//  ExerciseGuideListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/19/23.
//

import SwiftUI

protocol ExerciseGuideListDependency {
    func tap(type: ExerciseGuideListView.BigExerciseInfoType)
    func tap(type: ExerciseGuideListView.ExerciseInfoType)
}

struct ExerciseGuideListView: View {
    
    enum BigExerciseInfoType: String, CaseIterable {
        case squat
        case deadlift
        case benchPress = "bench press"
    }
    
    enum ExerciseInfoType: String, CaseIterable {
        case pullUp = "pull up"
    }
    
    let dependency: ExerciseGuideListDependency
    
    var body: some View {
        ZStack {
            Form {
                Section("big muscle") {
                    ForEach(BigExerciseInfoType.allCases, id: \.self) { type in
                        Button {
                            dependency.tap(type: type)
                        } label: {
                            Label(type.rawValue, systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
                
                Section {
                    ForEach(ExerciseInfoType.allCases, id: \.self) { type in
                        Button {
                            dependency.tap(type: type)
                        } label: {
                            Label(type.rawValue, systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
                
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    struct DP: ExerciseGuideListDependency {
        func tap(type: ExerciseGuideListView.BigExerciseInfoType) { }
        func tap(type: ExerciseGuideListView.ExerciseInfoType) { }
    }
    
    return ExerciseGuideListView(dependency: DP())
}
