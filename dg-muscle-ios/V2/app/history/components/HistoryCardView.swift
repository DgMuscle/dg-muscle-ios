//
//  HistoryCardView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct HistoryCardView: View {
    
    var dateString: String
    @Binding var duration: String
    
    let addAction: (() -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                Text(dateString)
            }
            .padding(.top)
            .fontWeight(.heavy)
            
            HStack {
                Image(systemName: "clock")
                Text(duration)
            }
            .padding(.top, 4)
            .fontWeight(.heavy)
            
            HStack {
                Button {
                    addAction?()
                } label: {
                    HStack {
                        Text("ADD RECORD")
                            .foregroundStyle(
                                LinearGradient(colors: [Color(uiColor: .label), .secondary],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                    }
                    .padding(.vertical)
                    .fontWeight(.heavy)
                    .font(.title3)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    HistoryCardView(dateString: "2024.04.14", duration: .constant("0 seconds"), addAction: nil)
        .preferredColorScheme(.dark)
}
