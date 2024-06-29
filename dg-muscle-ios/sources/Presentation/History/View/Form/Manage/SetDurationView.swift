//
//  SetDurationView.swift
//  History
//
//  Created by 신동규 on 6/29/24.
//

import SwiftUI
import Common
import Domain
import MockData

public struct SetDurationView: View {
    
    @State var hour: Int
    
    @State var minute: Int {
        didSet {
            if minute >= 60 {
                minute = 59
            }
        }
    }
    
    @State var seconds: Int {
        didSet {
            if seconds >= 60 {
                seconds = 59
            }
        }
    }
    
    private let pushRunDurationUsecase: PushRunDurationUsecase
    
    public init(
        duration: Int,
        historyRepository: HistoryRepository
    ) {
        
        hour = duration / 3600
        minute = (duration % 3600) / 60
        seconds = duration % 60
        
        pushRunDurationUsecase = .init(historyRepository: historyRepository)
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            HStack {
                HStack {
                    textField(placeholder: "hour", value: $hour)
                    Text("h")
                }
                
                HStack {
                    textField(placeholder: "minute", value: $minute)
                    Text("m")
                }
                
                HStack {
                    textField(placeholder: "seconds", value: $seconds)
                    Text("s")
                }
            }
            
            Button("Save") {
                pushRunDurationUsecase.implement(
                    duration: hour * 3600 + minute * 60 + seconds
                )
                URLManager.shared.open(url: "dgmuscle://pop")
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    
    func textField(placeholder: String, value: Binding<Int>) -> some View {
        TextField(placeholder, value: value, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .tertiarySystemFill))
            )
            .frame(width: 50)
    }
}

#Preview {
    SetDurationView(
        duration: 3648,
        historyRepository: HistoryRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
