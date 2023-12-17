import SwiftUI

protocol ExerciseFormDependency {
    func tapSave(data: Exercise)
}

struct ExerciseFormView: View {
    let dependency: ExerciseFormDependency
    let id: String?
    let order: Int?
    @State var name: String
    @State var selectedParts: [Exercise.Part]
    @State var favorite: Bool
    @State var saveButtonVisible: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Exercise Form").font(.largeTitle)
                Spacer()
            }
            .padding()
            
            Form {
                Section("name") {
                    TextField("name", text: $name)
                }
                
                Section("parts") {
                    ForEach(Exercise.Part.allCases, id: \.self) { part in
                        HStack {
                            Button {
                                withAnimation {
                                    if let index = selectedParts.firstIndex(of: part) {
                                        selectedParts.remove(at: index)
                                    } else {
                                        selectedParts.append(part)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(part.rawValue).foregroundStyle(Color(uiColor: .label))
                                    Spacer()
                                }
                            }
                            if selectedParts.contains(part) {
                                Image(systemName: "checkmark").foregroundStyle(.blue)
                            }
                        }
                    }
                }
                
                Toggle("Favorite", isOn: $favorite)
            }
            
            if saveButtonVisible {
                Button {
                    let largestOrder = store.exercise.exercises.sorted(by: { $0.order < $1.order }).last?.order ?? 0
                    
                    let data = Exercise(id: self.id ?? UUID().uuidString, name: name, parts: selectedParts, favorite: favorite, order: order ?? largestOrder + 1, createdAt: nil)
                    dependency.tapSave(data: data)
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10).fill(.blue)
                        }
                        .padding()
                }
            }
        }
        .onChange(of: name) { _, newValue in
            withAnimation {
                saveButtonVisible = !newValue.isEmpty
            }
        }
    }
}

#Preview {
    struct DP: ExerciseFormDependency {
        func tapSave(data: Exercise) { }
    }
    
    return ExerciseFormView(dependency: DP(), id: nil, order: nil, name: "", selectedParts: [], favorite: true, saveButtonVisible: false)
}
