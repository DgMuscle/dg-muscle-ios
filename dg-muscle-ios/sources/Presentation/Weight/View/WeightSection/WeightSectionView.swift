//
//  WeightSectionView.swift
//  Weight
//
//  Created by 신동규 on 8/7/24.
//

import SwiftUI
import Domain
import MockData

struct WeightSectionView: View {
    let section: WeightSection
    
    let deleteAction: ((WeightPresentation) -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sectionTitle()).bold()
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Date")
                    .padding(.horizontal)
                    .frame(width: 100)

                Text("Weight")
                Spacer()
            }
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
            }
            .overlay {
                HStack {
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: 30)
                        .padding(.trailing)
                        .offset(x: 90)
                    
                    Spacer()
                }
            }
            
            ForEach(Array(section.weights.enumerated()), id: \.element.self) { index, weight in
                VStack {
                    HStack {
                        Text(date(weight: weight))
                            .frame(width: 100)
                        Text("\(String(weight.value)) \(weight.unit.rawValue)")
                        Spacer()
                    }
                    
                    if index != section.weights.count - 1 {
                        Divider()
                    }
                }
                .contextMenu {
                    Button("Delete") {
                        deleteAction?(weight)
                    }
                }
            }
        }
    }
    
    private func sectionTitle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy.M"
        return dateFormatter.string(from: section.date)
    }
    
    private func date(weight: WeightPresentation) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "M.dd"
        return dateFormatter.string(from: weight.date)
    }
}

#Preview {
    let usecase = GroupWeightsByGroupUsecase()
    let group = usecase.implement(weights: GetWeightsWithoutDuplicatesUsecase().implement(weights: WeightRepositoryMock().get()))
    let section = WeightSection(yyyyMM: "202407", weights: group["202407"]!.map({ .init(domain: $0) }))
    
    return WeightSectionView(section: section, deleteAction: nil)
        .preferredColorScheme(.dark)
}
