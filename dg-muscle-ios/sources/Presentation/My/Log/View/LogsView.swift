//
//  LogsView.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData

public struct LogsView: View {
    
    @StateObject var viewModel: LogsViewModel
    
    public init(logRepository: LogRepository) {
        _viewModel = .init(wrappedValue: .init(logRepository: logRepository))
    }
    
    public var body: some View {
        Text("LogsView")
    }
}

#Preview {
    LogsView(logRepository: LogRepositoryMock())
        .preferredColorScheme(.dark)
}
