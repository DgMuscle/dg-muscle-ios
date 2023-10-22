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
    @State var selectedData: Data?
    @State var markType: MarkType = .bar
    
    var body: some View {
        let max = datas.max(by: { $0.volume < $1.volume })?.volume ?? 0
        
        VStack {
            Chart(datas) { data in
                switch markType {
                case .bar:
                    BarMark(
                        x: .value("day", data.day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).gradient)
                    
                    if let selectedData, selectedData == data {
                        RuleMark(x: .value("day", selectedData.day))
                            .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                            .annotation {
                                VStack(alignment: .leading) {
                                    Text("volume")
                                        .font(.caption2)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    
                                    Text("\(Int(selectedData.volume))").font(.caption.bold())
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color(uiColor: .systemBackground).shadow(.drop(radius: 2)))
                                }
                            }
                    }
                    
                case .line:
                    LineMark(
                        x: .value("day", data.day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).gradient)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("day", data.day),
                        y: .value("volume", data.animate ? data.volume : 0)
                    )
                    .foregroundStyle(Color(.tintColor).opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                    
                }
            }
            .chartYScale(domain: 0...(max + 1500))
            .chartOverlay(content: { proxy in
                GeometryReader { innerProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    let location = value.location
                                    
                                    // Extract value from the location data.
                                    // Don't forget to include perfect data type.
                                    if let day: String = proxy.value(atX: location.x) {
                                        
                                        // Extract selected data from datas
                                        if let selectedData = datas.first(where: { $0.day == day }) {
                                            self.selectedData = selectedData
                                        }
                                    }
                                })
                                .onEnded({ value in
                                    self.selectedData = nil
                                })
                        )
                }
            })
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
    
    static func generateDataBasedOnExercise(from histories: [ExerciseHistory], exerciseId: String, length: Int) -> [Data] {
        
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
            if volume > 0 {
                dateVolumeDictionary[date] = volume
            }
        }
        
        return dateVolumeDictionary.map({ .init(date: $0.key, volume: $0.value) }).sorted(by: { $0.date < $1.date }).suffix(length).map({ $0 })
    }
    
    static func generateDataBasedOnPart(from histories: [ExerciseHistory], part: Exercise.Part, length: Int) -> [Data] {
        
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
            if volume > 0 {
                dateVolumeDictionary[date] = volume
            }
        }
        
        return dateVolumeDictionary.map({ .init(date: $0.key, volume: $0.value) }).sorted(by: { $0.date < $1.date }).suffix(length).map({ $0 })
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
}

extension ChartView {
    struct Data: Identifiable, Equatable {
        let id = UUID().uuidString
        let date: Date
        let volume: Double
        var animate = false
        var day: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M.d"
            return dateFormatter.string(from: date)
        }
    }
    
    enum MarkType {
        case bar
        case line
    }
}
