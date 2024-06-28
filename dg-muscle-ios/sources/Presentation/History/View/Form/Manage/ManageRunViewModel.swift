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
import Common

final class ManageRunViewModel: ObservableObject {
    
    @Binding private var run: RunPresentation
    
    let color: Color
    @Published var distanceText: String
    @Published var durationText: String
    @Published var averageVelocityText: String
    @Published var runBarPercentage: CGFloat = 0
    
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
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository
    ) {
        self._run = run
        getAverageVelocityUsecase = .init()
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        
        distance = run.distance.wrappedValue
        duration = run.duration.wrappedValue
        averageVelocity = getAverageVelocityUsecase.implement(run: run.wrappedValue.domain)
        
        distanceText = MKDistanceFormatter().string(fromDistance: run.distance.wrappedValue)
        durationText = Self.durationFormatter.string(from: TimeInterval(run.duration.wrappedValue)) ?? ""
        averageVelocityText = "\(getAverageVelocityUsecase.implement(run: run.wrappedValue.domain)) km/h"
        
        color = Common.HeatMapColor(domain: getHeatMapColorUsecase.implement()).color
        
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
            .map({ "\($0) km/h" })
            .assign(to: &$averageVelocityText)
        
        $averageVelocity
            .receive(on: DispatchQueue.main)
            .map({ $0 / 10 })
            .assign(to: &$runBarPercentage)
        
        $distance
            .combineLatest($duration)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] distance, duration in
                self?.run.duration = duration
                self?.run.distance = distance
            }
            .store(in: &cancellables)
    }
}
