//
//  ExerciseListSectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ExerciseListSectionView: View {
    
    let exerciseAction: (() -> ())?
    let guideAction: (() -> ())?
    let appleWatchAction: (() -> ())?
    
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
                guideAction?()
            } label: {
                SettingListItemView(systemImageName: "a.book.closed",
                                    title: "Exercise Guide",
                                    description: nil,
                                    color: .red)
            }
            
            Button {
                appleWatchAction?()
            } label: {
                SettingListItemView(systemImageName: "applewatch",
                                    title: "Apple Watch Guide",
                                    description: nil,
                                    color: .orange)
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
    ExerciseListSectionView(exerciseAction: nil, guideAction: nil, appleWatchAction: nil)
        .preferredColorScheme(.dark)
}
