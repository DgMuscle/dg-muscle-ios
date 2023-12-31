import SwiftUI

protocol ExerciseInfoContainerDependency {
    func addExercise(exercise: Exercise)
}

struct ExerciseInfoContainerView: View {
    let contentView: AnyView
    let exerciseName: String
    let exerciseParts: [Exercise.Part]
    let dependency: ExerciseInfoContainerDependency
    
    @State var isShowingAddExerciseBottomSheet = false
    @State var exerciseFavorite = true
    @StateObject var exerciseStore: ExerciseStore = store.exercise
    
    init(type: ExerciseType, dependency: ExerciseInfoContainerDependency) {
        self.dependency = dependency
        switch type {
        case .squat:
            contentView = AnyView(SquatInfoView())
            exerciseName = "squat"
            exerciseParts = [.leg]
        case .deadlift:
            contentView = AnyView(DeadliftInfoView())
            exerciseName = "deadlift"
            exerciseParts = [.back, .leg]
        case .benchpress:
            contentView = AnyView(BenchPressInfoView())
            exerciseName = "bench press"
            exerciseParts = [.chest]
        case .pullUp:
            contentView = AnyView(PullUpInfoView())
            exerciseName = "pull up"
            exerciseParts = [.back]
        case .bicepCurl:
            contentView = AnyView(BicepCurlInfoView())
            exerciseName = "bicep curl"
            exerciseParts = [.arm]
        case .legCurl:
            contentView = AnyView(LegCurlInfoView())
            exerciseName = "leg curl"
            exerciseParts = [.leg]
        case .legExtension:
            contentView = AnyView(LegExtensionInfoView())
            exerciseName = "leg extension"
            exerciseParts = [.leg]
        case .legPress:
            contentView = AnyView(LegPressInfoView())
            exerciseName = "leg press"
            exerciseParts = [.leg]
        case .pushUp:
            contentView = AnyView(PushUpInfoView())
            exerciseName = "push up"
            exerciseParts = [.chest]
        case .tricepPushdown:
            contentView = AnyView(TricepPushDownInfoView())
            exerciseName = "tricep pushdown"
            exerciseParts = [.arm]
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black).ignoresSafeArea()
            
            contentView
            
            VStack(alignment: .trailing) {
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        isShowingAddExerciseBottomSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .bold()
                            .padding(10)
                            .background { Circle().fill(.blue).opacity(0.7) }
                    }
                }
            }
            .padding(.trailing, 20)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isShowingAddExerciseBottomSheet, content: {
            VStack(alignment: .leading) {
                
                HStack(spacing: 20) {
                    Text("Do you want to add this exercise into you exercise list?")
                    
                    Button {
                        let exercise = Exercise(id: UUID().uuidString, name: exerciseName, parts: exerciseParts, favorite: exerciseFavorite, order: exerciseStore.exercises.count + 1, createdAt: nil)
                        dependency.addExercise(exercise: exercise)
                        isShowingAddExerciseBottomSheet.toggle()
                    } label: {
                        Text("yes").foregroundStyle(.white)
                            .padding(8)
                            .background { RoundedRectangle(cornerRadius: 4).fill(.blue).opacity(0.6) }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("name: \(exerciseName)")
                    Text("exercise parts: \(partsToString(parts: exerciseParts))")
                    
                    Toggle("favorite", isOn: $exerciseFavorite)
                }
                .padding()
                .background { RoundedRectangle(cornerRadius: 8).fill(.black) }
                
            }
            .presentationDetents([.height(260), .medium])
            .padding()
        })
    }
    
    private func partsToString(parts: [Exercise.Part]) -> String {
        parts.map({ $0.rawValue }).joined(separator: ", ")
    }
}

extension ExerciseInfoContainerView {
    enum ExerciseType {
        case benchpress
        case bicepCurl
        case deadlift
        case legCurl
        case legExtension
        case legPress
        case pullUp
        case pushUp
        case squat
        case tricepPushdown
    }
}

#Preview {
    struct DP: ExerciseInfoContainerDependency {
        func addExercise(exercise: Exercise) {
            print(exercise)
        }
    }
    return ExerciseInfoContainerView(type: .pullUp, dependency: DP())
}
