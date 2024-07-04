//
//  DateToSelectHistoryView.swift
//  Domain
//
//  Created by 신동규 on 7/4/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct DateToSelectHistoryView: View {
    
    let pushDateToSelectHistoryUsecase: PushDateToSelectHistoryUsecase
    @State var date: Date
    
    private let now = Date()
    
    public init(historyRepository: HistoryRepository) {
        pushDateToSelectHistoryUsecase = .init(historyRepository: historyRepository)
        self.date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    }
    
    public var body: some View {
        VStack {
            DatePicker("Date to select record", selection: $date, displayedComponents: .date)
            
            HStack {
                Spacer()
                Button("Select") {
                    URLManager.shared.open(url: "dgmuscle://pop")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        pushDateToSelectHistoryUsecase.implement(date: date)
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .onChange(of: date) { oldValue, newValue in
            if newValue >= now || Calendar.current.isDate(newValue, inSameDayAs: now) {
                date = oldValue
            }
        }
    }
}

#Preview {
    DateToSelectHistoryView(historyRepository: HistoryRepositoryMock())
        .preferredColorScheme(.dark)
}
