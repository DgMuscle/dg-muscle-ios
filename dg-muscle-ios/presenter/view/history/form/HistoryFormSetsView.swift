//
//  HistoryFormSetsView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import SwiftUI

struct HistoryFormSetsView: View {
    
    @StateObject var viewModel: HistoryFormSetsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Set's count  :\(viewModel.currentSetsCount)")
                Text("Set's Volume :\(viewModel.currentRecordVolume)")
                
                
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.exercise?.name ?? "Error: Can't find exercise".capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
