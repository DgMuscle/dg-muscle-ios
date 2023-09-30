//
//  TabView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI

struct TabView: View {
    @State var selectedTab: TabItemsView.Tab = .diary
    var exerciseDiaryView: ExerciseDiaryView
    var settingView: SettingView
    
    init(
        uid: String,
        settingViewDependency: SettingViewDependency,
        exerciseDiaryDependency: ExerciseDiaryDependency
    ) {
        exerciseDiaryView = .init(dependency: exerciseDiaryDependency)
        settingView = .init(dependency: settingViewDependency)
        store.history.updateHistories(uid: uid)
        store.exercise.updateExercises(uid: uid)
    }
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .diary:
                exerciseDiaryView
            case .setting:
                settingView
            }
            TabItemsView(selectedTab: $selectedTab)
        }
    }
}
