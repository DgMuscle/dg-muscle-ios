//
//  ExercisePartSelectionItem.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExercisePartSelectionItem: View {
    
    var part: Exercise.Part
    var selected: Bool
    
    let action: ((Exercise.Part) -> ())?
    
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

#Preview {
    return VStack {
        ExercisePartSelectionItem(part: .leg, selected: true, action: nil)
        ExercisePartSelectionItem(part: .leg, selected: false, action: nil)
    }
    .preferredColorScheme(.dark)
}
