//
//  FriendSearchTextField.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/26/24.
//

import SwiftUI

struct FriendSearchTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextField("Search by display name", text: $text)
                .padding(8)
                .background(
                    Capsule()
                        .fill(Color(uiColor: .secondarySystemGroupedBackground))
                )
            
            HStack {
                Spacer()
                if text.isEmpty == false {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                    .padding(.trailing)
                }
            }
        }
        
    }
}

#Preview {
    FriendSearchTextField(text: .constant(""))
        .preferredColorScheme(.dark)
}
