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
    let dp: FullRecordsViewDependency
    @State var history: ExerciseHistory
    @State var exercises: [Exercise]
    @State var failToMakeImage = false
    
    @State var image: UIImage?
    
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        ScrollView {
            if failToMakeImage {
                HStack {
                    Text("Fail to make image file.")
                        .foregroundStyle(.red)
                        .italic()
                    Spacer()
                }
            }
            
            if let image {
                VStack(alignment: .leading) {
                    HStack {
                        ShareLink("Share", item: Image(uiImage: image), preview: SharePreview(Text("Shared image"), image: Image(uiImage: image)))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button("Save") {
                            dp.save(image: image)
                        }
                        .padding(.leading, 28)
                        Spacer()
                    }
                    
                }
                .padding(.horizontal)
                
            }
            
            contents(history: history)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("\(history.date)'s Record")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    if let image = makeImage() {
                        self.image = image
                    } else {
                        self.failToMakeImage = true
                    }
                    
                }
            }
        }
    }
    
    func contents(history: ExerciseHistory) -> some View {
        VStack {
            ForEach(history.records) { record in
                RecordView(record: record, exercise: exercises.first(where: { $0.id == record.exerciseId }))
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(uiColor: .secondarySystemBackground))
                    }
                    .padding()
            }
            
            Section {
                HStack {
                    Text("Total volume is")
                    Text("\(Self.formatted(double: history.volume))")
                        .foregroundStyle(.green)
                        .italic()
                }
            }
            
            Spacer()
        }
    }
    
    @MainActor func makeImage() -> UIImage? {
        let renderer = ImageRenderer(content: contents(history: history))
        // make sure and use the correct display scale for this device
        renderer.scale = displayScale
        return renderer.uiImage
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
