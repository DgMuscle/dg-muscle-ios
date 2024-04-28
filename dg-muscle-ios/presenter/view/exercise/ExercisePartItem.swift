//
//  ExercisePartItem.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExercisePartItem: View {
    
    let part: ExerciseV.Part
    let selected: Bool
    
    let action: ((ExerciseV.Part) -> ())?
    
    var body: some View {
        Button {
            action?(part)
        } label: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(selected ? .green : .secondary)
                    .font(.title)
                
                Text(part.rawValue.capitalized)
                    .fontWeight(.black)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .secondarySystemBackground))
            )
        }
    }
}
