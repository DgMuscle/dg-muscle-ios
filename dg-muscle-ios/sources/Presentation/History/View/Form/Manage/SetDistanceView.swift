//
//  SetDistanceView.swift
//  History
//
//  Created by 신동규 on 6/28/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct SetDistanceView: View {
    
    @State var distance: Double
    @FocusState var focus
    
    private let pushRunDistanceUsecase: PushRunDistanceUsecase
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    public init(
        distance: Double,
        historyRepository: HistoryRepository
    ) {
        _distance = .init(initialValue: distance / 1000)
        pushRunDistanceUsecase = .init(historyRepository: historyRepository)
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 20) {
                TextField("Distance", value: $distance, formatter: numberFormatter)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .tertiarySystemFill))
                    )
                    .keyboardType(.decimalPad)
                    .focused($focus)
                Text("km")
            }
            
            Button("Save") {
                pushRunDistanceUsecase.implement(distance: distance * 1000)
                URLManager.shared.open(url: "dgmuscle://pop")
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            focus.toggle()
        }
    }
}

#Preview {
    SetDistanceView(
        distance: 6700,
        historyRepository: HistoryRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
