//
//  WatchWorkoutAppInfoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/18/23.
//

import SwiftUI

struct WatchWorkoutAppInfoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Make use of apple watch")
                            .font(.largeTitle)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Text("1. Turn on apple watch's workout app")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image("watch home", bundle: nil)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Spacer(minLength: 40)
                        
                        HStack(spacing: 0) {
                            Text("2. Select ")
                            Text("'Traditional Strength Training'")
                                .italic()
                                .font(.footnote)
                                .bold()
                            Spacer()
                        }
                        
                        Image("workout app", bundle: nil)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Spacer(minLength: 40)
                        
                        Text("3. Start recording at the beginning of the exercise, and stop recording at the end of the exercise.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Text("You can see your exercise duration, kcal consumed, intensity.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image("exercise history item with metadata", bundle: nil)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    .padding()
                }
                .foregroundStyle(Color.white)
            }
            .padding(10)
            .scrollIndicators(.hidden)
        }
    }
}
