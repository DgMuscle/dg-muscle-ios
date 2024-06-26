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
    private let subscribeRunDistanceUsecase: SubscribeRunDistanceUsecase
    private let subscribeRunDurationUsecase: SubscribeRunDurationUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository,
        historyRepository: HistoryRepository
    ) {
        self._run = run
        getAverageVelocityUsecase = .init()
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        subscribeRunDistanceUsecase = .init(historyRepository: historyRepository)
        subscribeRunDurationUsecase = .init(historyRepository: historyRepository)
        
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
            .map({ String(format: "%.2f", $0) })
            .map({ velocityText in
                var velocityText = velocityText
                
                while velocityText.last == "0" {
                    velocityText.removeLast()
                }
                
                return velocityText
            })
            .map({ "\($0) km/h" })
            .assign(to: &$averageVelocityText)
        
        $averageVelocity
            .receive(on: DispatchQueue.main)
            .map({ $0 / 10 })
            .map({ min($0, 1) })
            .assign(to: &$runBarPercentage)
        
        $distance
            .combineLatest($duration)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] distance, duration in
                self?.run.duration = duration
                self?.run.distance = distance
                guard let self else { return }
                averageVelocity = getAverageVelocityUsecase.implement(run: run.domain)
            }
            .store(in: &cancellables)
        
        subscribeRunDistanceUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .assign(to: &$distance)
        
        subscribeRunDurationUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .assign(to: &$duration)
    }
}
