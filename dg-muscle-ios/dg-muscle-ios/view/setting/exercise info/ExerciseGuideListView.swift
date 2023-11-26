//
//  ExerciseGuideListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/19/23.
//

import SwiftUI

protocol ExerciseGuideListDependency {
    func tapSquat()
}

struct ExerciseGuideListView: View {
    
    let dependency: ExerciseGuideListDependency
    
    var body: some View {
        ZStack {
            Form {
                Button {
                    dependency.tapSquat()
                } label: {
                    Label("squat", systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    struct DP: ExerciseGuideListDependency {
        func tapSquat() { }
    }
    
    return ExerciseGuideListView(dependency: DP())
}
