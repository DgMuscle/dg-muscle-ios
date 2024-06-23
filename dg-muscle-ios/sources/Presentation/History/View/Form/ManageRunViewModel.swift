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
    
    @Published var velocity: Double
    @Published var runPieces: [Common.RunPiece]
    @Published var status: RunPresentation.Status
    
    @Published var runGraphPercentage: Double = 0
    @Published var startTime: String = ""
    @Published var endTime: String = ""
    @Published var distance: String = ""
    @Published var color: Common.HeatMapColor
    @Published var statusView: Common.StatusView.Status? = nil
    
    @Binding var run: RunPresentation
    
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let subscribeRunVelocityUpdatesUsecase: SubscribeRunVelocityUpdatesUsecase
    private let getRunGraphPercentageUsecase: GetRunGraphPercentageUsecase
    private let getRunDistanceUsecase: GetRunDistanceUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        run: Binding<RunPresentation>,
        userRepository: UserRepository,
        runRepository: RunRepository
    ) {
        self._run = run
        self.runPieces = run.pieces.wrappedValue
        self.status = run.status.wrappedValue
        self.velocity = run.pieces.wrappedValue.last?.velocity ?? 0
        self.getHeatMapColorUsecase = .init(userRepository: userRepository)
        self.color = .init(domain: getHeatMapColorUsecase.implement())
        self.subscribeRunVelocityUpdatesUsecase = .init(runRepository: runRepository)
        self.getRunGraphPercentageUsecase = .init()
        self.getRunDistanceUsecase = .init()
        
        bind()
        
        configureViewData()
        
        // 타이머 설정
        Timer.publish(every: 6.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.executeEverySecond()
            }
            .store(in: &cancellables)
        
        // Velocity graph 업데이트
        Timer.publish(every: 200, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if self?.status == .running {
                    self?.start()
                }
            }
            .store(in: &cancellables)
    }
    
    func update(velocity: Double) {
        if status == .running && velocity <= 0 {
            statusView = .error("Can't set velocity under 0 when running.")
            return
        }
        
        self.velocity = velocity
        if velocity > 0 {
            start()
        }
    }
    
    func tapButton() {
        switch status {
        case .running:
            stop()
        case .notRunning:
            start()
        }
        configureViewData()
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
                dateFormatter.dateFormat = "h.m a"
                return dateFormatter.string(from: $0)
            })
            .sink(receiveValue: { [weak self] time in
                self?.startTime = time
            })
            .store(in: &cancellables)
        
        $status
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] status in
                self?.run.status = status
            }
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
        
        if status == .running {
            if let index = runPieces.indices.last {
                runPieces[index].end = .init()
            }
        }
        
        self.runGraphPercentage = getRunGraphPercentageUsecase.implement(
            runPieces: runPieces.map({
                $0.domain
            })
        )
        
        self.distance = getRunDistanceUsecase.implement(
            runPieces: runPieces.map({
                $0.domain
            })
        )
        
        guard let end = run.pieces.last?.end else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h.m a"
        
        self.endTime = dateFormatter.string(from: end)
    }
    
    @objc private func executeEverySecond() {
        configureViewData()
    }
}
