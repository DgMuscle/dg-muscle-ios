//
//  ExercisePartSecltionItem.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExercisePartSecltionItem: View {
    
    @State var part: Exercise.Part
    @State var selected: Bool
    
    let action: ((Exercise.Part) -> ())?
    
    var body: some View {
        Button {
            action?(part)
        } label: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(selected ? .green : .secondary)
                    .font(.title)
                
                Text(part.rawValue)
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
        ExercisePartSecltionItem(part: .leg, selected: true, action: nil)
        ExercisePartSecltionItem(part: .leg, selected: false, action: nil)
    }
    .preferredColorScheme(.dark)
}
