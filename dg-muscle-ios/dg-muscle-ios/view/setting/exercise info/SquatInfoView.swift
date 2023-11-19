//
//  SquatInfoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/19/23.
//

import SwiftUI

struct SquatInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Squat")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up. During the descent, the hip and knee joints flex while the ankle joint dorsiflexes; conversely the hip and knee joints extend and the ankle joint plantarflexes when standing up. Squats also help the hip muscles.")
                    .padding()
                
                Image("squat", bundle: nil)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background { RoundedRectangle(cornerRadius: 8) }
                    .padding()
                
                Text("1. stand in a relaxed manner. Open your feet shoulder-width apart and attach your arms lightly to your body.")
                
                Spacer(minLength: 20)
                
                Text("2. As you balance and breathe in, bend your knees and lower your upper body above your waist. Never raise your heels at this time. Keep the upper body as upright as possible so that the back of the waist stays arched. A bend in the waist causes injury.")
                
                Spacer(minLength: 20)
                
                Text("3. Lower your waist until your thighs and bottom are parallel. And stay in parallel for about a second if possible. As you breathe out, raise your waist while standing up your knees and back.")
                
                Spacer(minLength: 20)
                
                Text("4. Repeat 1 to 3.")
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SquatInfoView()
}

