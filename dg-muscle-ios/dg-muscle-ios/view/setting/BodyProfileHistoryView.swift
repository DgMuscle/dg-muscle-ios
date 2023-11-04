//
//  BodyProfileHistoryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/4/23.
//

import SwiftUI

struct BodyProfileHistoryView: View {
    
    let profile: Profile
    @State var datas: [ChartView.Data]
    @State var markType: ChartView.MarkType = .bar
    
    init(profile: Profile) {
        self.profile = profile
        datas = profile.specs.map({ .init(date: $0.date, value: $0.weight, valueName: "weight") })
            .sorted(by: { $0.date < $1.date })
            .suffix(7)
    }
    
    var body: some View {
        VStack {
            Picker("mark type", selection: $markType) {
                ForEach(ChartView.MarkType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Weight(kg)")
                            .font(.largeTitle)
                            .bold()
                            .italic()
                        
                        Spacer()
                    }
                    
                    ChartView(
                        datas: datas,
                        markType: $markType,
                        valueName: "weight", 
                        additionalMax: 40
                    )
                    .frame(height: 250)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
    }
}

