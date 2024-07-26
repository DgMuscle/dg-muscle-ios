//
//  RapidSearchByNameView.swift
//  App
//
//  Created by Donggyu Shin on 7/23/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct RapidSearchByNameView: View {
    
    @StateObject var viewModel: RapidSearchByNameViewModel
    
    public init(rapidRepository: RapidRepository) {
        _viewModel = .init(wrappedValue: .init(rapidRepository: rapidRepository))
    }
    
    public var body: some View {
        ScrollView {
            if viewModel.loading {
                ProgressView()
                    .padding(.top)
            }
            VStack {
                ForEach(viewModel.datas, id: \.self) { data in
                    Button {
                        URLManager.shared.open(url: "dgmuscle://rapid_detail?id=\(data.id)")
                    } label: {
                        VStack {
                            ExerciseThumbnailView(data: data)
                            Divider()
                        }
                        .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    return NavigationStack {
        RapidSearchByNameView(rapidRepository: RapidRepositoryMock())
    }
    .preferredColorScheme(.dark)
}
