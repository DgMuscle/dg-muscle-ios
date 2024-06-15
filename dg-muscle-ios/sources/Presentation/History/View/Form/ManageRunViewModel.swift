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
    @Published var color: Common.HeatMapColor
    
    @Binding var run: RunPresentation
    
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(run: Binding<RunPresentation>, userRepository: UserRepository) {
        self._run = run
        self.runPieces = run.pieces.wrappedValue
        self.velocity = run.pieces.wrappedValue.last?.velocity ?? 0
        self.getHeatMapColorUsecase = .init(userRepository: userRepository)
        self.color = .init(domain: getHeatMapColorUsecase.implement())
        
        bind()
        
        // 타이머 설정
        let timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(
                executeEverySecond
            ),
            userInfo: nil,
            repeats: true
        )
        
        // 타이머가 실행될 수 있도록 현재 RunLoop에 추가
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func update(velocity: Double) {
        self.velocity = velocity
        start()
    }
    
    func tapButton() {
        switch status {
        case .running:
            status = .notRunning
            stop()
        case .notRunning:
            status = .running
            start()
        }
    }
    
    private func start() {
        let now = Date()
        
        if let index = runPieces.indices.last {
            runPieces[index].end = now
        }
        
        runPieces.append(.init(velocity: velocity, start: now))
    }
    
    private func stop() {
        let now = Date()
        
        if let index = runPieces.indices.last {
            runPieces[index].end = now
        }
    }
    
    private func bind() {
        $runPieces
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: \.run.pieces, on: self)
            .store(in: &cancellables)
        
        $runPieces
            .compactMap({ $0.first?.start })
            .map({
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "H.m.s"
                return dateFormatter.string(from: $0)
            })
            .assign(to: \.startTime, on: self)
            .store(in: &cancellables)
    }
    
    private func configureRunGraphPercentage() {
        var result: Double = 0
        let totalDuration = Double(run.duration)
        let hour: Double = 3600
        
        result = totalDuration / hour
        result = min(result, 1)
        
        self.runGraphPercentage = result
    }
    
    @objc private func executeEverySecond() {
        configureRunGraphPercentage()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H.m.s"
        
        self.endTime = dateFormatter.string(from: Date())
    }
}
