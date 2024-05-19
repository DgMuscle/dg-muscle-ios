//
//  ListItemView.swift
//  My
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI

struct ListItemView: View {
    
    let systemName: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemName).foregroundStyle(color)
                .frame(width: 40)
            Text(text)
            Spacer()
        }
        .fontWeight(.heavy)
        .foregroundStyle(Color(uiColor: .label))
    }
}

#Preview {
    return VStack {
        ListItemView(systemName: "person", text: "Profile", color: .blue)
        
        ListItemView(systemName: "dumbbell", text: "Exercise", color: .red)
    }
    .preferredColorScheme(.dark)
}
