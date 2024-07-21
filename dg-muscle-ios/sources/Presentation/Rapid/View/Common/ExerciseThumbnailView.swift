//
//  ExerciseThumbnailView.swift
//  Rapid
//
//  Created by 신동규 on 7/22/24.
//

import SwiftUI
import Domain
import MockData

struct ExerciseThumbnailView: View {
    
    typealias Thumbnail = RapidExerciseThumbnailPresentation
    
    let data: Thumbnail
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(data.name)
                Spacer()
            }
            
            Text(data.bodyPart.rawValue)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(
                    Capsule().fill(data.bodyPart.color)
                )
        }
    }
}

#Preview {
    return ExerciseThumbnailView(data: .init(domain: RAPID_EXERCISES[1]))
        .preferredColorScheme(.dark)
}
