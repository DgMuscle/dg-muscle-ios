//
//  BenchpressInfoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/3/23.
//

import SwiftUI

struct BenchPressInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Bench press")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The bench press, or chest press, is a weight training exercise where a person presses a weight upwards while lying horizontally on a weight training bench. Although the bench press is a full-body exercise, the muscles primarily used are the pectoralis major, the anterior deltoids, and the triceps, among other stabilizing muscles. A barbell is generally used to hold the weight, but a pair of dumbbells can also be used.")
                    .padding()
                
                Image("benchpress", bundle: nil)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background { RoundedRectangle(cornerRadius: 8) }
                    .padding()
                
                Text("1. Lie on your back on a flat bench. Grip a barbell with hands slightly wider than shoulder width. The bar should be directly over the shoulders.")
                
                Spacer(minLength: 20)
                
                Text("2. Press your feet firmly into the ground and keep your hips on the bench throughout the entire movement.")
                
                Spacer(minLength: 20)
                
                Text("3. Keep your core engaged and maintain a neutral spine position throughout the movement. Avoid arching your back.")
                
                Spacer(minLength: 20)
                
                Text("4. Slowly lift the bar or dumbbells off the rack, if using. Lower the bar to the chest, about nipple level, allowing elbows to bend out to the side, about 45 degrees away from the body.")
                
                Spacer(minLength: 20)
                
                Text("5. Stop lowering when your elbows are just below the bench. Press feet into the floor as you push the bar back up to return to starting position.")
                
                Spacer(minLength: 20)
                
                Text("6. Perform 5 to 10 reps, depending on weight used. Perform up to 3 sets.")
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    BenchPressInfoView()
}

