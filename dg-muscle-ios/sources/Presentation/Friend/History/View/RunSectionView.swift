//
//  RunSectionView.swift
//  Friend
//
//  Created by 신동규 on 6/29/24.
//

import SwiftUI
import MapKit
import MockData
import Domain

struct RunSectionView: View {
    
    let run: Run
    @State var extended: Bool = false
    private let getAverageVelocityUsecase: GetAverageVelocityUsecase
    
    private static var durationFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter
    }
    
    init(run: Run) {
        self.run = run
        getAverageVelocityUsecase = .init()
    }
    
    var body: some View {
        Section("run") {
            Text(MKDistanceFormatter().string(fromDistance: run.distance))
            
            if extended {
                Text(Self.durationFormatter.string(from: TimeInterval(run.duration)) ?? "")
                
                Text("\(removeZero(velocity: getAverageVelocityUsecase.implement(run: run.domain))) km/h")
            }
        }
        .onTapGesture {
            extended.toggle()
        }
        .animation(.default, value: extended)
    }
    
    private func removeZero(velocity: Double) -> String {
        var velocityText = String(format: "%.2f", velocity)
        while velocityText.last == "0" {
            velocityText.removeLast()
        }
        return velocityText
    }
}

#Preview {
    List {
        RunSectionView(run: .init(domain: HISTORY_1.run!))
    }
    .preferredColorScheme(.dark)
}
