//
//  ExerciseSimpleInfoView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct ExerciseSimpleInfoView: View {
    
    @State var name: String
    @State var parts: [Exercise.Part]
    @Binding var favorite: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name).fontWeight(.black).font(.title)
                Button {
                    favorite.toggle()
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(favorite ? .yellow : .secondary)
                }
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text("Target parts are").foregroundStyle(.secondary)
                Text(parts.map({ $0.rawValue }).joined(separator: ", "))
                    .fontWeight(.heavy).italic()
            }
        }
    }
}

#Preview {
    
    @State var favorite: Bool = false
    
    return ExerciseSimpleInfoView(name: "Squat", parts: [.leg], favorite: $favorite)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
