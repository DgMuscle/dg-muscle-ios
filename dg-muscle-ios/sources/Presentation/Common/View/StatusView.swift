//
//  StatusView.swift
//  Common
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI

public struct StatusView: View {
    
    public enum Status: Equatable {
        case loading
        case success(String?)
        case error(String?)
    }
    
    let status: Status
    
    var text: String? {
        switch status {
        case .loading:
            return nil
        case .success(let string):
            return string
        case .error(let string):
            return string
        }
    }
    
    public init(status: Status) {
        self.status = status
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            iconView(status: status)
            if let text {
                Text(text)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    Color(uiColor: .secondarySystemGroupedBackground)
                )
        )
    }
    
    func iconView(status: Status) -> some View {
        ZStack {
            switch status {
            case .loading:
                ProgressView()
            case .success:
                Image(systemName: "checkmark.circle").foregroundStyle(.green)
            case .error:
                Image(systemName: "exclamationmark.circle").foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    return StatusView(status: .error("error text"))
        .preferredColorScheme(.dark)
}
