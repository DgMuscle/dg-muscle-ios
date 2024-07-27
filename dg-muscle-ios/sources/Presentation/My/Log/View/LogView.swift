//
//  LogView.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import MockData
import Kingfisher

struct LogView: View {
    
    let log: DGLog
    let resolve: ((DGLog) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(log.category.rawValue)
                    .foregroundStyle(log.category.color)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                log.category.color.opacity(0.3)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(log.category.color, lineWidth: 1) // 1px border line 추가
                            )
                    )
                
                Spacer()
                
                if let url = log.user?.photoURL {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                
                if let displayName = log.user?.displayName {
                    Text(displayName)
                }
                
            }
            Text(log.message)
            Text(log.createdAt.formatted())
                .font(.caption2)
            
            HStack {
                Button {
                    resolve?(log)
                } label: {
                    Image(systemName: "circle.badge.checkmark")
                        .font(.title)
                        .foregroundStyle(log.resolved ? Color.green : Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

#Preview {
    
    var log: DGLog = .init(domain: LOGS[0])
    log.expanded = true
    log.user = .init(displayName: USERS[0].displayName ?? "DG", photoURL: USERS[0].photoURL)
    
    return LogView(log: log, resolve: nil)
        .preferredColorScheme(.dark)
}
