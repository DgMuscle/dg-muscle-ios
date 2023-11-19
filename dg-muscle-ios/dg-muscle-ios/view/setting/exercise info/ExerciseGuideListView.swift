//
//  ExerciseGuideListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/19/23.
//

import SwiftUI

struct ExerciseGuideListView: View {
    
    enum ShowType {
        case squat
    }
    
    let dependency: ExerciseInfoContainerDependency
    @State var showType: ShowType = .squat
    @State var showing = false
    
    var body: some View {
        ZStack {
            Form {
                Button {
                    showType = .squat
                    withAnimation {
                        showing.toggle()
                    }
                } label: {
                    Label("squat", systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                }
            }
            .scrollIndicators(.hidden)
            
            if showing {
                switch showType {
                case .squat:
                    ExerciseInfoContainerView(contentView: AnyView(SquatInfoView()),
                                              exerciseName: "squat",
                                              exerciseParts: [.leg],
                                              dependency: dependency,
                                              exerciseStore: store.exercise,
                                              isShowing: $showing)
                }
            }
        }
    }
}

#Preview {
    struct DP: ExerciseInfoContainerDependency {
        func addExercise(exercise: Exercise) { }
    }
    
    return ExerciseGuideListView(dependency: DP())
}

