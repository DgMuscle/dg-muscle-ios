//
//  HealthInfoItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HealthInfoItemView: View {
    
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
                    .foregroundStyle(.white)
            }
            
                
            
            Text(label).fontWeight(.black)
            
            Spacer()
            
            Text(value).font(.headline)
        }
    }
}
