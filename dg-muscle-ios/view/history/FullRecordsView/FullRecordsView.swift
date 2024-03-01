//
//  FullRecordsView.swift
//  dg-muscle-workspace
//
//  Created by 신동규 on 3/1/24.
//

import SwiftUI

protocol FullRecordsViewDependency {
    func save(image: UIImage)
}

struct FullRecordsView: View {
    struct ShareImage {
        var isShowing = false
        var image: UIImage? = nil
    }
    
    
    let dp: FullRecordsViewDependency
    @State var history: ExerciseHistory
    @State var exercises: [Exercise]
    @State var isShowingBottomsheet = false
    @State var failToMakeImage = false
    @State var shareImage = ShareImage()
    
    var body: some View {
        Form {
            if failToMakeImage {
                HStack {
                    Text("Fail to make image file.")
                        .foregroundStyle(.red)
                        .italic()
                    Spacer()
                }
            }
            
            ForEach(history.records) { record in
                Section {
                    RecordView(record: record, exercise: exercises.first(where: { $0.id == record.exerciseId }))
                }
            }
            
            Section {
                HStack {
                    Text("Total volume is")
                    Text("\(Self.formatted(double: history.volume))")
                        .foregroundStyle(.green)
                        .italic()
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("\(history.date)'s Record")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingBottomsheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $isShowingBottomsheet, content: {
            BottomSheet {
                isShowingBottomsheet = false
                if let image = makeImage() {
                    dp.save(image: image)
                } else {
                    withAnimation {
                        failToMakeImage = true
                    }
                }
            } shareAction: {
                isShowingBottomsheet = false
                if let image = makeImage() {
                    shareImage.image = image
                    shareImage.isShowing = true
                } else {
                    withAnimation {
                        failToMakeImage = true
                    }
                }
            }
            .presentationDetents([.height(150)])
        })
        .sheet(isPresented: $shareImage.isShowing) {
            if let image = shareImage.image {
                ActivityView(activityItems: [image], applicationActivities: nil)
            }
        }
    }
    
    func makeImage() -> UIImage? {
        let hostingController = UIHostingController(rootView: self)
        let image = snapshot(view: hostingController.view)
        return image
    }
    
    func snapshot(view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
    }
    
    static func formatted(double: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6 // Adjust this value based on your needs
        return formatter.string(from: NSNumber(value: double)) ?? ""
    }
}

#Preview {
    struct DP: FullRecordsViewDependency {
        func share(image: UIImage) {
            print(image)
        }
        func save(image: UIImage) {
            print(image)
        }
    }
    
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 65, id: "1"),
        .init(unit: .kg, reps: 10, weight: 65.2, id: "2"),
        .init(unit: .kg, reps: 10, weight: 65, id: "3"),
        .init(unit: .kg, reps: 10, weight: 65, id: "4"),
    ]
    
    let records: [Record] = [
        .init(id: "id1", exerciseId: "squat", sets: sets),
        .init(id: "id2", exerciseId: "bench", sets: sets),
    ]
    
    let exercises: [Exercise] = [
        .init(id: "squat", name: "squat", parts: [.leg], favorite: true, order: 0, createdAt: nil),
        .init(id: "bench", name: "bench", parts: [.chest], favorite: true, order: 1, createdAt: nil)
    ]
    
    let history = ExerciseHistory(id: "id1", date: "20240301", memo: "sample memo", records: records, createdAt: nil)
    
    return FullRecordsView(dp: DP(), history: history, exercises: exercises).preferredColorScheme(.dark)
}
