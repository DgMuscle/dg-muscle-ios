//
//  ExerciseDiaryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import SwiftUI

protocol ExerciseDiaryDependency {
    func tapAddHistory()
    func tapHistory(history: ExerciseHistory)
    func scrollBottom()
}

struct ExerciseDiaryView: View {
    
    let dependency: ExerciseDiaryDependency
    
    @StateObject var historyStore = store.history
    @State var addFloatingButtonVisible = false
    
    var body: some View {
        ZStack {
            List {
                Button("Add record", systemImage: "plus.app") {
                    dependency.tapAddHistory()
                }
                .onAppear {
                    withAnimation {
                        addFloatingButtonVisible = false
                    }
                }
                .onDisappear {
                    withAnimation {
                        addFloatingButtonVisible = true
                    }
                }
                
                ForEach(historyStore.historySections) { section in
                    Section {
                        ForEach(section.histories) { history in
                            Button {
                                dependency.tapHistory(history: history)
                            } label: {
                                HStack {
                                    Text(history.date).frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(history.volume)").frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .foregroundStyle(Color(uiColor: .label))
                            }
                            .onAppear {
                                if history == store.history.histories.last {
                                    dependency.scrollBottom()
                                }
                            }
                        }
                    } header: {
                        Text(section.header)
                    } footer: {
                        Text("total volume: \(section.footer)")
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            VStack {
                Spacer()
                if addFloatingButtonVisible {
                    Button("Add", systemImage: "plus.app") {
                        dependency.tapAddHistory()
                    }
                    .padding()
                    .background {
                        Capsule().fill(Color(uiColor: .secondarySystemBackground)).opacity(0.5)
                    }
                }
            }
        }
    }
}

