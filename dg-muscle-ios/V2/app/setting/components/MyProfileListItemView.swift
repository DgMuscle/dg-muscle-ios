//
//  MyProfileListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/16/24.
//

import SwiftUI

struct MyProfileListItemView: View {
    
    var systemImageName: String
    var iconBackgroundColor: Color
    var label: String
    var value: String
    
    private let iconSize: CGFloat = 30
    
    var body: some View {
        HStack{
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(iconBackgroundColor)
                    .frame(width: iconSize, height: iconSize)
                Image(systemName: systemImageName)
            }
            
                
            
            Text(label).fontWeight(.black)
            
            Spacer()
            
            Text(value).font(.headline)
        }
    }
}

#Preview {
    MyProfileListItemView(systemImageName: "drop.fill", iconBackgroundColor: .red, label: "Blood Type", value: "O+")
        .preferredColorScheme(.dark)
}
