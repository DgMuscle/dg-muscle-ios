//
//  ChartView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/21/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State var datas: [Data]
    @State var markType: MarkType = .bar
    
    var body: some View {
        let max = datas.max(by: { $0.volume < $1.volume })?.volume ?? 0
        
        VStack {
            Chart(datas) { data in
                
                switch markType {
                case .bar:
                    BarMark(
                        x: .value("date", data.date, unit: .day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).gradient)
                    
                case .line:
                    LineMark(
                        x: .value("date", data.date, unit: .day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).gradient)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("date", data.date, unit: .day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                    
                }
            }
            .chartYScale(domain: 0...(max + 2000))
            .onAppear {
                animateGraph()
            }
            .onChange(of: markType) { _, _ in
                animateGraph()
            }
            
            HStack {
                Spacer()
                Picker("Mark Type", selection: $markType) {
                    Text("bar").tag(MarkType.bar)
                    Text("line").tag(MarkType.line)
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }
        }
    }
    
    private func animateGraph() {
        datas.enumerated().forEach { index, _ in
            datas[index].animate = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06 * Double(index)) {
                withAnimation(.easeInOut) {
                    datas[index].animate = true
                }
            }
        }
    }
    
    static func generateDataBasedOnExercise(from histories: [ExerciseHistory], exerciseId: String) -> [Data] {
        
        var dateHistoryDictionary: [Date: ExerciseHistory] = [:]
        var dateVolumeDictionary: [Date: Double] = [:]
        
        histories.forEach { history in
            if let date = history.dateValue {
                dateHistoryDictionary[date] = history
            }
        }
        
        dateHistoryDictionary.forEach { (date, history) in
            let records = history.records.filter({ $0.exerciseId == exerciseId })
            let volume = records.reduce(0, { $0 + $1.volume })
            dateVolumeDictionary[date] = volume
        }
        
        return dateVolumeDictionary.map({ .init(date: $0.key, volume: $0.value) }).sorted(by: { $0.date < $1.date })
    }
    
    static func generateDataBasedOnPart(from histories: [ExerciseHistory], part: Exercise.Part) -> [Data] {
        
        var dateHistoryDictionary: [Date: ExerciseHistory] = [:]
        var dateVolumeDictionary: [Date: Double] = [:]
        
        histories.forEach { history in
            if let date = history.dateValue {
                dateHistoryDictionary[date] = history
            }
        }
        
        dateHistoryDictionary.forEach { (date, history) in
            let records = history.records.filter({ $0.parts.contains(part) })
            let volume = records.reduce(0, { $0 + $1.volume })
            dateVolumeDictionary[date] = volume
        }
        
        return dateVolumeDictionary.map({ .init(date: $0.key, volume: $0.value) }).sorted(by: { $0.date < $1.date })
    }
}

extension ChartView {
    struct Data: Identifiable {
        let id = UUID().uuidString
        let date: Date
        let volume: Double
        var animate = false
    }
    
    enum MarkType {
        case bar
        case line
    }
}

