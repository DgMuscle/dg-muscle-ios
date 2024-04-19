//
//  SettingListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SettingListItemView: View {
    
    private let rectangleSize: CGFloat = 32
    
    var systemImageName: String
    var title: String
    var description: String?
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: rectangleSize, height: rectangleSize)
                Image(systemName: systemImageName)
                    .padding(4)
                    .foregroundStyle(.white)
            }
            .padding(.trailing, 4)
            VStack(alignment: .leading) {
                Text(title).fontWeight(.black)
                
                if let description {
                    Text(description).font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .foregroundStyle(Color(uiColor: .label))
    }
}

#Preview {
    SettingListItemView(systemImageName: "dumbbell.fill",
                        title: "Exercise",
                        description: "Manage your exercise list",
                        color: .red)
        .preferredColorScheme(.dark)
}
