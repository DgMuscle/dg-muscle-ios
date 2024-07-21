//
//  RapidSearchByBodyPartView.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import SwiftUI
import Domain
import MockData
import Common
import Flow

public struct RapidSearchByBodyPartView: View {
    
    @StateObject var viewModel: RapidSearchByBodyPartViewModel
    
    public init(rapidRepository: RapidRepository) {
        _viewModel = .init(wrappedValue: .init(rapidRepository: rapidRepository))
    }
    
    public var body: some View {
        ScrollView {
            HFlow {
                ForEach(viewModel.bodyParts, id: \.self) { data in
                    bodyPart(data: data)
                        .onTapGesture {
                            viewModel.tapPart(part: data)
                        }
                }
            }
            
            VStack {
                ForEach(viewModel.datas, id: \.self) { data in
                    Button {
                        print("tap \(data.id)")
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
    }
    
    func bodyPart(data: BodyPart) -> some View {
        Text(data.name.capitalized)
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(
                        data.selected ?
                            .blue :
                            Color(uiColor: .secondarySystemGroupedBackground)
                    )
            )
    }
}

#Preview {
    RapidSearchByBodyPartView(rapidRepository: RapidRepositoryMock())
        .preferredColorScheme(.dark)
}
