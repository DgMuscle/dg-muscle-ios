import SwiftUI

protocol ExerciseGuideListDependency {
    func tap(type: ExerciseGuideListView.BigExerciseInfoType)
    func tap(type: ExerciseGuideListView.ExerciseInfoType)
}

struct ExerciseGuideListView: View {
    
    enum BigExerciseInfoType: String, CaseIterable {
        case squat
        case deadlift
        case benchPress = "bench press"
    }
    
    enum ExerciseInfoType: String, CaseIterable {
        case bicepCurl = "bicep curl"
        case legCurl = "leg curl"
        case legExtension = "leg extension"
        case legPress = "leg press"
        case pullUp = "pull up"
        case pushUp = "push up"
        case tricepPushdown = "tricep pushdown"
    }
    
    let dependency: ExerciseGuideListDependency
    
    var body: some View {
        ZStack {
            Form {
                Section("big muscle") {
                    ForEach(BigExerciseInfoType.allCases, id: \.self) { type in
                        Button {
                            dependency.tap(type: type)
                        } label: {
                            Label(type.rawValue, systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
                
                Section {
                    ForEach(ExerciseInfoType.allCases, id: \.self) { type in
                        Button {
                            dependency.tap(type: type)
                        } label: {
                            Label(type.rawValue, systemImage: "chevron.right").foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
                
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    struct DP: ExerciseGuideListDependency {
        func tap(type: ExerciseGuideListView.BigExerciseInfoType) { }
        func tap(type: ExerciseGuideListView.ExerciseInfoType) { }
    }
    
    return ExerciseGuideListView(dependency: DP())
}
