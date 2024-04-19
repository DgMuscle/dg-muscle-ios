//
//  ExerciseListSectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListSectionView: View {
    
    let exerciseAction: (() -> ())?
    let introduceAction: (() -> ())?
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                exerciseAction?()
            } label: {
                SettingListItemView(systemImageName: "dumbbell.fill",
                                    title: "Exercise",
                                    description: "Manage your exercise list",
                                    color: .pink)
            }
            
            Button {
                introduceAction?()
            } label: {
                SettingListItemView(systemImageName: "a.book.closed",
                                    title: "DgMuscle Introduce",
                                    description: nil,
                                    color: .red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
    }
}

#Preview {
    ExerciseListSectionView(exerciseAction: nil, introduceAction: nil)
        .preferredColorScheme(.dark)
}
