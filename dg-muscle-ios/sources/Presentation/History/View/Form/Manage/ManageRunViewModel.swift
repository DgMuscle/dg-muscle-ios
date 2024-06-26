//
//  ManageRunViewModel.swift
//  Domain
//
//  Created by 신동규 on 6/26/24.
//

import Foundation
import Combine
import Domain
import SwiftUI
import MapKit

final class ManageRunViewModel: ObservableObject {
    
    @Binding private var run: RunPresentation
    
    @Published var distanceText: String
    @Published var durationText: String
    @Published var averageVelocityText: String
    
    @Published var distance: Double
    @Published var duration: Int
    @Published var averageVelocity: Double
    
    private static var durationFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter
    }
    
    private let getAverageVelocityUsecase: GetAverageVelocityUsecase
    
    init(run: Binding<RunPresentation>) {
        self._run = run
        getAverageVelocityUsecase = .init()
        
        distance = run.distance.wrappedValue
        duration = run.duration.wrappedValue
        averageVelocity = getAverageVelocityUsecase.implement(run: run.wrappedValue.domain)
        
        distanceText = MKDistanceFormatter().string(fromDistance: run.distance.wrappedValue)
        durationText = Self.durationFormatter.string(from: TimeInterval(run.duration.wrappedValue)) ?? ""
        averageVelocityText = String(format: "%.2f", getAverageVelocityUsecase.implement(run: run.wrappedValue.domain))

        bind()
    }
    
    private func bind() {
        $distance
            .receive(on: DispatchQueue.main)
            .map({ MKDistanceFormatter().string(fromDistance: $0) })
            .assign(to: &$distanceText)
        
        $duration
            .receive(on: DispatchQueue.main)
            .compactMap({ Self.durationFormatter.string(from: TimeInterval($0)) })
            .assign(to: &$durationText)
        
        $averageVelocity
            .receive(on: DispatchQueue.main)
            .map({ String(format: "%.2f", $0) })
            .assign(to: &$averageVelocityText)
    }
}
