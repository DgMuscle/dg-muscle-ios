//
//  RapidExerciseDetailView.swift
//  Rapid
//
//  Created by 신동규 on 7/26/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher
import Flow

public struct RapidExerciseDetailView: View {
    
    let data: RapidExercisePresentation
    @State private var showsSecondaryMuscles: Bool = false
    
    public init(exercise: Domain.RapidExerciseDomain) {
        data = .init(domain: exercise)
    }
    
    public var body: some View {
        ScrollView {
            
            KFAnimatedImage(.init(string: data.gifUrl))
            
            VStack(alignment: .leading) {
                Text(data.equipment.capitalized)
                    .fontWeight(.black)
                
                Divider()
                
                HStack {
                    Text("Body Part:")
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .italic()
                    Text("\(data.bodyPart.rawValue.capitalized)(\(data.target.capitalized))")
                }
                
                Spacer(minLength: 8)
                
                Section {
                    if showsSecondaryMuscles {
                        HFlow {
                            ForEach(data.secondaryMuscles, id: \.self) { secondaryMuscle in
                                Text(secondaryMuscle)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color(uiColor: .secondarySystemGroupedBackground))
                                    )
                            }
                        }
                    }
                } header: {
                    Button {
                        showsSecondaryMuscles.toggle()
                    } label: {
                        HStack {
                            Text("secondary muscles".capitalized)
                        }
                    }
                }
                
                Spacer(minLength: 12)
                
                
                Text("Instructions")
                    .font(.title)
                    .padding(.bottom, 8)
                
                
                ForEach(Array(zip(data.instructions.indices, data.instructions)), id: \.0) { (index, instruction) in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text(instruction)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.bottom, 8)
                }
                
                
            }
            .padding(.horizontal)
            
            
        }
        .animation(.default, value: showsSecondaryMuscles)
        .navigationTitle(data.name)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    
    let repository = RapidRepositoryMock()
    
    return NavigationStack {
        RapidExerciseDetailView(exercise: repository.get()[0])
            .preferredColorScheme(.dark)
    }
}
