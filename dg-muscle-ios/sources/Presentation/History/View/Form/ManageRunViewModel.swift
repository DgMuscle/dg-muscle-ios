//
//  ManageRunViewModel.swift
//  History
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Combine
import Domain
import SwiftUI
import Common

final class ManageRunViewModel: ObservableObject {
    
    enum Status {
        case running
        case notRunning
    }
    
    @Published var velocity: Double
    @Published var runPieces: [RunPiece]
    @Published var status: Status = .notRunning
    @Published var runGraphPercentage: Double = 0
    @Published var startTime: String = ""
    @Published var endTime: String = ""
    @Published var distance: String = ""
    @Published var color: Common.HeatMapColor
    @Published var statusView: Common.StatusView.Status? = nil
    
    @Binding var run: RunPresentation
    
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let subscribeRunVelocityUpdatesUsecase: SubscribeRunVelocityUpdatesUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository,
        runRepository: RunRepository
    ) {
        self._run = run
        self.runPieces = run.pieces.wrappedValue
        self.velocity = run.pieces.wrappedValue.last?.velocity ?? 0
        self.getHeatMapColorUsecase = .init(userRepository: userRepository)
        self.color = .init(domain: getHeatMapColorUsecase.implement())
        self.subscribeRunVelocityUpdatesUsecase = .init(runRepository: runRepository)
        
        bind()
        
        configureViewData()
        
        // 타이머 설정
        Timer.publish(every: 6.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.executeEverySecond()
            }
            .store(in: &cancellables)
    }
    
    func update(velocity: Double) {
        self.velocity = velocity
        start()
    }
    
    func tapButton() {
        switch status {
        case .running:
            stop()
        case .notRunning:
            start()
            executeEverySecond()
        }
    }
    
    private func start() {
        if velocity == 0 {
            statusView = .error("Configure Velocity before run.")
            return
        }
        
        let now = Date()
        
        if let index = runPieces.indices.last {
            if runPieces[index].end == nil {
                runPieces[index].end = now
            }
        }
        
        runPieces.append(.init(velocity: velocity, start: now))
        status = .running
    }
    
    private func stop() {
        status = .notRunning
    }
    
    private func bind() {
        $runPieces
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] pieces in
                self?.run.pieces = pieces
            }
            .store(in: &cancellables)
        
        $runPieces
            .compactMap({ $0.first?.start })
            .map({
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH.mm"
                return dateFormatter.string(from: $0)
            })
            .sink(receiveValue: { [weak self] time in
                self?.startTime = time
            })
            .store(in: &cancellables)
        
        subscribeRunVelocityUpdatesUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] velocity in
                self?.update(velocity: velocity)
            }
            .store(in: &cancellables)
    }
    
    private func configureViewData() {
        
        if let index = runPieces.indices.last {
            runPieces[index].end = .init()
        }
        
        var result: Double = 0
        let totalDuration = Double(run.duration)
        let hour: Double = 3600
        
        result = totalDuration / hour
        result = min(result, 1)
        
        self.runGraphPercentage = result
        
        self.distance = String(format: "%.2f", run.distance) + " km"
        
        let end = run.pieces.last?.end ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        
        self.endTime = dateFormatter.string(from: end)
    }
    
    @objc private func executeEverySecond() {
        if status == .running {
            configureViewData()
        }
    }
}
