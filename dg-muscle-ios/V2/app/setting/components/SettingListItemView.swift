//
//  SettingListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SettingListItemView: View {
    
    private let rectangleSize: CGFloat = 32
    
    @State var systemImageName: String
    @State var title: String
    @State var description: String?
    @State var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: rectangleSize, height: rectangleSize)
                Image(systemName: systemImageName)
                    .padding(4)
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
